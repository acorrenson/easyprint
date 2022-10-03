# easyprint


EasyPrint is a simple OCaml script to print double-sided documents on
printers that don't support double-sided printing.

EasyPrint slices pdf documents into several printing units. You can then print the units
separately and flip the paper when indicated.

## Usage

```
dune exec ./main.exe my_pdf.pdf
```

This will generate several packages `my_pdf_printer_n.pdf` and display instructions.