local status, t9 = pcall(require, "cmp_tabnine.config")
if (not status) then return end

t9.setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    show_prediction_strength = true,
    ignored_file_types = {}
})
