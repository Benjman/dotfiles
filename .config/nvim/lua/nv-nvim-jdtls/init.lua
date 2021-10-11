--[[
    a few notes:
        - install jdtls: https://github.com/eclipse/eclipse.jdt.ls#installation
        - install java (current max version is 11): https://adoptium.net/?variant=openjdk11
        - install apache maven: https://maven.apache.org/download.cgi
        - modify -jar -data and -configuration paths
--]]
local config = {
    -- The command that starts the language server
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-noverify',
        '-Xmx1G',
        '-jar ~/.local/lib/eclipse.jdt.ls',
        '-jar ./plugins/org.eclipse.equinox.launcher_1.5.200.v20180922-1751.jar',
        '-configuration ./config_linux',
        '-data /path/to/data',
        --add-modules=ALL-SYSTEM \
        --add-opens java.base/java.util=ALL-UNNAMED \
        --add-opens java.base/java.lang=ALL-UNNAMED
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({'.git', 'mvn', 'gradle'})
}
--require('jdtls').start_or_attach(config)
