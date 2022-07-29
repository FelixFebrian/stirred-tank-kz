#!/bin/sh
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
    dstDir="${FOAM_RUN}/meshStudy/constant/triSurface"

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


clean_all
copy_surface
preprocess
simpleFoam 2>&1 | tee logs/log.simpleFoam

# # Source tutorial run functions
# . $WM_PROJECT_DIR/bin/tools/RunFunctions

# # Get application directory
# application=$(getApplication)

# runApplication blockMesh
# runApplication topoSet
# runApplication refineHexMesh c0 -overwrite

# runApplication decomposePar -cellDist
# runParallel $application

# runApplication reconstructPar

#------------------------------------------------------------------------------
