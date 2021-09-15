#!/bin/sh
# cd ${0%/*} || exit 1    # Run from this directory
foamCleanCase
mkdir -p logs


# Function definitions
# Copy and scale surface stl-files
function copy_surface {
    # Copy all the stl files from cad to constant/triSurface
    srcDir="${FOAM_RUN}/cad"
    dstDir="${FOAM_RUN}/meshStudy/constant/triSurface"

    mkdir -p ${dstDir}

    for stlFile in ${srcDir}/*.stl; do
        basename=${stlFile##*/}
        surfaceConvert -clean -scale 0.001 \
            ${stlFile} "${dstDir}/${basename}" | tee -a logs/log.surfaceConvert
    done
}


copy_surface

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
