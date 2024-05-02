import subprocess

# List of files to run
files_to_run = ["db_init.py", "load_data.py", "push_data.py"]


# Loop through the files and run them one by one
for file in files_to_run:
    # Check if it's a .py file or .ipynb file and execute accordingly
    print(f"Running {file}")
    if file.endswith('.py'):
        subprocess.run(["python", file])
    # elif file.endswith('.ipynb'):
    #     print(f"ipynb is {file}")
    #     print(file.replace('.ipynb', '.py'))
    #     subprocess.run(["jupyter", "nbconvert", "--to", "script", file])
    #     subprocess.run(["python", file.replace('.ipynb', '.py')])
    else:
        print("Unsupported file format:", file)
