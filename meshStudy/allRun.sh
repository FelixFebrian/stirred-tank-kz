#!/bin/sh
# cd ${0%/*} || exit 1    # Run from this directory
mkdir -p logs


# Function definitions
# Copy and scale surface stl-files
function copy_surface {
    srcDir="${FOAM_RUN}/cad"
    dstDir="${FOAM_RUN}/meshStudy/constant/triSurface"
    # stlFiles=

    mkdir -p ${dstDir}

    # for stlFile in "${stlFiles[@]}"; do
    for stlFile in 'tank' 'baffles' 'fluidSurface' 'shaft' 'rushton' 'pbt'; do
        surfaceConvert -clean -scale 0.001 \
            "${srcDir}/${stlFile}.stl" "${dstDir}/${stlFile}.stl" | tee -a logs/log.surfaceConvert
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
