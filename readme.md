# Search Context Script

This script searches for a specified term within a directory and provides context around each occurrence. It can be run interactively or in the background, saving the output to a file.

## Usage

```sh
./search_context.sh <directory> <search_term> <context_length> [output_file]
```

- `<directory>`: The directory to search within.
- `<search_term>`: The term to search for.
- `<context_length>`: The total number of characters to show around each occurrence of the search term.
- `[output_file]`: Optional. If provided, the script will run in the background using `nohup` and save the output to this file.

## Example

### Run interactively and output to the terminal:

```sh
./search_context.sh /path/to/directory username 50
```

### Run in the background and save output to a file:

```sh
./search_context.sh /path/to/directory username 50 output.txt
```

## Script Details

### Argument Validation

The script checks if the correct number of arguments is provided and ensures the context length is a valid number.

### Context Calculation

The script calculates half of the context length to display the specified number of characters before and after the search term.

### Search Function

The `search_with_context` function:
- Recursively searches within the specified directory using `grep`.
- Excludes "Permission denied" and "Invalid argument" messages.
- Uses `awk` to limit the output to the specified context around the search term.

### Conditional Execution

- If no output file is specified, the script runs normally and prints the output to the terminal.
- If an output file is specified, the script runs with `nohup` in the background and saves the output to the specified file.

## License

This script is provided under the MIT License.

## Contributions

Feel free to open issues or submit pull requests if you have suggestions for improvements or find any bugs.
