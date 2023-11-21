using LinearAlgebra,PrettyTables

t = 0:1:20;
data = hcat(t, ones(length(t)) * 1, 1 * t, 0.5 .* t.^2);
header = (["Time", "Acceleration", "Velocity", "Distance"],
                 [ "[s]",       "[m/s²]",    "[m/s]",      "[m]"]);
                 hl_v = LatexHighlighter((data, i, j) -> (j == 3) && data[i, 3] > 9, HtmlDecoration(color = "blue", font_weight = "bold"));
                 hl_p = LatexHighlighter((data, i, j) -> (j == 4) && data[i, 4] > 10, HtmlDecoration(color = "red"));
                 hl_e = LatexHighlighter((data, i, j) -> data[i, 1] == 10, HtmlDecoration(background = "black", color = "white"))



pretty_table(data; backend = Val(:latex), header = header, highlighters = (hl_e, hl_p, hl_v), standalone = true)