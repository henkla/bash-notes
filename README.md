# bash-notes
A quick and easy way to take and store notes on the fly from the bash shell.

## Get startet
##### 1. put file in bin folder of choice
`bin_dir='/some/location/then/bin' && mkdir -p $bin_dir && cp /location/of/script/<filename> $bin_dir`

##### 2. make script executable
`chmod u+x <filename>`

##### 3. put location in PATH variable
`echo 'PATH=$PATH:/dir/where/file/is/located' >> ~/.bashrc`

##### 4. create an alias for script execution (optional)
`echo "alias note='<filename>'" >> ~/.bashrc`

## How to use it
Here is a really quick guide to help you get started instantly:

##### To take a quick note:
`note "your note here"`

##### To quickly list all notes:
`note`

##### To display all available options:
`note -h` (-h: help)

## Sample execution
`note "sample note"`

`note -vl` (-v: verbose, -l: list)

`    1  20-02-07 15:53:45       sample note`
