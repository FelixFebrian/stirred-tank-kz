#!/bin/bash
# cd ${0%/*} || exit 1    # Run from this directory

# Function definitions
clean_all() {
    foamCleanCase
    rm -rf logs
    rm -rf constant/triSurface
    mkdir -p logs
    touch meshStudy.foam
}

copy_surface() {
    # Copy and scale surface stl-files from cad to constant/triSurface
    srcDir="${FOAM_RUN}/cad"
    dstDir="${PWD}/constant/triSurface"

    mkdir -p ${dstDir}

    for stlFile in ${srcDir}/*.stl; do
        basename=${stlFile##*/}
        surfaceConvert -clean -scale 0.001 \
            ${stlFile} "${dstDir}/${basename}" | tee -a logs/log.surfaceConvert
    done
}

preprocess() {
    # Mesh the geometry
    blockMesh 2>&1 | tee logs/log.blockMesh
    snappyHexMesh -overwrite 2>&1 | tee logs/log.snappyHexMesh
    checkMesh 2>&1 | tee logs/log.checkMesh
}

run_simulation() {
    # Run the simulation
    simpleFoam 2>&1 | tee logs/log.simpleFoam
}

postprocess() {
    # Run postprocessing step
    foamLog logs/log.simpleFoam
    gnuplot gnuplot/script.gnuplot

    simpleFoam -postProcess -func "yPlus" -latestTime
    LATESTTIME=$(foamListTimes -latestTime)
    for PATCH in stirrer baffles tank shaft
    do
        foamDictionary $LATESTTIME/yPlus -entry boundaryField/$PATCH/value -value > postProcessing/yPlus/$LATESTTIME/$PATCH.dat
        sed -i -e 1,3d postProcessing/yPlus/$LATESTTIME/$PATCH.dat
    done
    gnuplot -e "time='$LATESTTIME'" gnuplot/yPlus.gnuplot
}

run_all() {
    clean_all
    copy_surface
    preprocess
    run_simulation
    postprocess
}

"$@"

#------------------------------------------------------------------------------
