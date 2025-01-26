mkdir -p dir1/dir2
touch dir1/dir2/file
ln -s dir1/dir2/file dir1/link_to_file
echo "symbolic link details " > symlink_details.txt
ls -l dir1/link_to_file >> symlink_details.txt
echo "Directory structure with symboliclink details" > outputq3.txt
ls -lR dir1 >> outputq3.txt
cat symlink_details.txt >> outputq3.txt
