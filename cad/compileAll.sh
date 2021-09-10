# !/bin/sh

echo "Compile all the scad-files in this directory ..."
for filename in *.scad
do
    echo "Compiling file ${filename}"
    openscad -o "${filename%%.*}.stl" ${filename}
done
echo "All done!"
