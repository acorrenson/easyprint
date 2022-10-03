(*-------------------------------------------------*)
(*                   - EasyPrint -                 *)
(*                                                 *)
(*  An OCaml script for double sided printing on   *)
(*  a standard printer.                            *)
(*-------------------------------------------------*)


let split_even n =
  [
    List.init (n / 2) (fun i -> 2 * i + 1);
    List.init (n / 2) (fun i -> 2 * i + 2);
  ]

let split_odd n =
  if n <= 1 then [[1]]
  else (split_even (n - 1)) @ [[n]]

let process pdf name cut =
  List.iteri (fun i l ->
    let fn    = Printf.sprintf "%s_printer_%d.pdf" (Filename.chop_suffix name ".pdf") (i + 1) in
    let pdf'  = Pdfpage.pdf_of_pages pdf l in
    Printf.printf "Processing package %s (%d pages)\n" fn (List.length l);
    Pdfwrite.pdf_to_file pdf' fn
  ) cut

let () =
  let name = Sys.argv.(1) in
  let pdf = Pdfread.pdf_of_file None None name in
  let page_num = Pdfpage.endpage pdf in
  Printf.printf "Pre-printing %d pages\n" page_num;
  if page_num mod 2 = 0 then begin
    Printf.printf "Generating 2 packages\n";
    process pdf name (split_even page_num);
    Printf.printf "Instructions\n";
    Printf.printf "   Print package 1\n";
    Printf.printf "   Flip the paper\n";
    Printf.printf "   Print package 2\n"
  end else begin
    Printf.printf "Generating 3 packages\n";
    process pdf name (split_odd page_num);
    Printf.printf "Instructions\n";
    Printf.printf "   Print package 1\n";
    Printf.printf "   Flip the paper\n";
    Printf.printf "   Print package 2\n";
    Printf.printf "   Print package 3\n"
  end

