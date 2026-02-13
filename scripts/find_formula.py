import os
import sys
import difflib

def find_formula(query, formula_dir="Formula"):
    formulas = [f[:-3] for f in os.listdir(formula_dir) if f.endswith(".rb")]
    
    if not query:
        return None, formulas

    # Exact match
    if query in formulas:
        return query, formulas

    # Substring match fallback
    for f in formulas:
        if query in f:
            return f, formulas

    # Best guess using difflib
    matches = difflib.get_close_matches(query, formulas, n=1, cutoff=0.4)
    if matches:
        return matches[0], formulas
        
    return None, formulas

if __name__ == "__main__":
    query = sys.argv[1] if len(sys.argv) > 1 else ""
    match, all_formulas = find_formula(query)
    if match:
        print(f"MATCH: {match}")
    else:
        print("NO MATCH")
        print("Available formulas:", ", ".join(all_formulas))
