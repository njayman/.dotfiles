local njayman_modules = {
	"njayman.core.editor",
	"njayman.core.mappings",
	"njayman.core.lazy",
}

for _, mod in ipairs(njayman_modules) do
	local ok, err = pcall(require, mod)
	-- cosmic.config files may or may not be present
	-- if not ok and not mod:find('cosmic.config') then
	if not ok then
		error(("Error loading %s...\n\n%s"):format(mod, err))
	end
end
