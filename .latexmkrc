$engine = 'xelatex';  # <-- This is the missing line!

# Specify the LaTeX engine (using xelatex for better Unicode support)
$latex = 'xelatex -synctex=1 %O %S';  # Use xelatex instead of pdflatex

# Use biber for bibliography processing
$bibtex = 'biber %O %S';

# Enable PDF output (this is important for PDFLaTeX and Biber)
$pdf_mode = 1;

# Ensure multiple runs of LaTeX and Biber to resolve all references and citations
$max_run_count = 5;   # Limit the number of compilation passes (adjust if necessary)

# Run Biber after the first LaTeX pass
$bibtex_use = 2;  # Use '2' to force Biber as the bibliography processor (instead of BibTeX).

# Suppress interactive prompts, making it ideal for automated builds
$interactive = 0;

# Enable clean-up of auxiliary files after compilation (you can disable this if you want to keep intermediate files)
$clean_ext = 'bbl blg aux log out toc fls fdb_latexmk';

# Custom post-processing for specific files if needed (can be expanded)
# For instance, cleaning up PDF before moving to final version or creating backups
