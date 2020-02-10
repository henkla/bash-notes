# bash-notes
A quick and easy way to take and store notes on the fly from the bash shell.

## Setup
1. put file in bin folder of choice
2. `chmod u+x <filename>`
3. put location in PATH: `PATH=$PATH:/dir/where/file/is/located`
4. create an alias for script execution: Ex: `echo 'alias note='<filename>' >> ~/.bashrc'`

## Usage
Here is a really quick guide to help you get started instantly:

##### To take a quick note:
`note "your note here"`

##### To quickly list all notes:
`note`

##### To display all available options:
`note -h` (-h: help)

## Sample usage
`note "sample note"`

`note -vl` (-v: verbose, -l: list)

`    1  20-02-07 15:53:45       sample note`
