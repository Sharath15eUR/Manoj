mkdir -p dir1/dir2
touch dir1/dir2/file.txt
ln -s dir1/dir2/file.txt dir1/link_to_file
echo "symbolic link:" > symbolic_link.txt
ls -l dir1/link_to_file >> symbolic_link.txt
echo "directory structure"
ls -lR dir1
