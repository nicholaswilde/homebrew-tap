import os
import sys
import argparse
from find_formula import find_formula

def main():
    parser = argparse.ArgumentParser(description="Update Homebrew formula")
    parser.add_argument("formula_name", nargs="?", help="Name of the formula to update")
    parser.add_argument("--dry-run", action="store_true", help="Preview changes without applying them")
    args = parser.parse_args()

    match, all_formulas = find_formula(args.formula_name)

    if not match:
        if args.formula_name:
            print(f"Error: Could not find formula matching '{args.formula_name}'")
        else:
            print("Error: No formula name provided.")
        print("Available formulas:", ", ".join(all_formulas))
        sys.exit(1)

    print(f"Selected formula: {match}")
    if args.dry_run:
        print("Running in DRY RUN mode.")

    # Future phases will implement the rest of the logic here
    print(f"DEBUG: Found formula file at Formula/{match}.rb")

if __name__ == "__main__":
    main()
