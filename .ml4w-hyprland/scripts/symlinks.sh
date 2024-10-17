#!/usr/bin/bash

echo ":: Creating symlinks"

symlinks=(

  ".config/Nextcloud"
  ".config/gdb"
  ".config/git"
  ".config/gnupg"
  ".config/hypr/conf/user"
  ".config/inputrc"
  ".config/lazygit"
  ".config/npm"
  ".config/nvim"
  ".config/zshrc/00-user-xdg-base-dirs"
  ".config/zshrc/01-user-exports"
  ".config/zshrc/01-user-path-extensions"
  ".config/zshrc/05-user-aliases"
  ".config/zshrc/99-user-caps_esc_swap"
  ".config/zshrc/99-user-zsh-cache-override"
  ".local/share/applications/magnet.desktop" # TODO: Update desktop database

)

: '

What is the recommended way of defining apps for xdg-open?
ChatGPT said:
ChatGPT

Defining applications for xdg-open involves creating a desktop entry file, which is used by desktop environments to associate file types or URLs with applications. Here’s how to do it:
Step 1: Create a Desktop Entry File

    Location: Place your .desktop file in one of these locations:
        User-specific: ~/.local/share/applications/
        System-wide: /usr/share/applications/

    File Naming: Name your file with a .desktop extension, for example, myapp.desktop.

Step 2: Structure of the Desktop Entry

Your .desktop file should have the following structure:

ini

[Desktop Entry]
Version=1.0
Type=Application
Name=My Application
Exec=/path/to/myapp %U
Icon=/path/to/icon.png
Terminal=false
Categories=Utility;Application;
MimeType=text/plain;application/pdf; # specify supported MIME types

Key Fields Explained

    Version: The version of the desktop entry specification.
    Type: Should be Application.
    Name: The name of your application as it will appear in menus.
    Exec: The command to execute your application. Use %U for URLs or %f for files.
    Icon: Path to an icon for your application.
    Terminal: Set to true if your app requires a terminal to run.
    Categories: Specify categories for your application (helps in app menus).
    MimeType: Lists the MIME types your application can handle.

Step 3: Update Desktop Database

After creating or modifying a .desktop file, run the following command to update the desktop database:

bash

update-desktop-database ~/.local/share/applications

Step 4: Testing with xdg-open

Now you can test your application with xdg-open:

bash

xdg-open somefile.txt

Additional Notes

    Ensure that your application is executable and the paths in the .desktop file are correct.
    You can check if your entry is recognized using xdg-mime query default <mime-type>.
    For applications to be listed in menus, they should have the appropriate categories defined.

By following these steps, you can effectively define and integrate your application with xdg-open.
You said:
Demonstrate for a magnet file to be handled by transmission.
ChatGPT said:
ChatGPT

To set up xdg-open to handle magnet links with Transmission, you'll need to create a .desktop file specifically for this purpose. Here’s how you can do it:
Step 1: Create the Desktop Entry File

    Open a terminal.

    Create a new .desktop file in your local applications directory:

    bash

    nano ~/.local/share/applications/transmission-magnet.desktop

Step 2: Add the Following Content

Copy and paste the following content into the file:

ini

[Desktop Entry]
Version=1.0
Type=Application
Name=Transmission
Comment=Open Magnet Links with Transmission
Exec=transmission-gtk %U
Icon=transmission
Terminal=false
Categories=Network;P2P;
MimeType=x-scheme-handler/magnet;

Key Fields Explained

    Exec: This is the command to run Transmission. Depending on your installation, it might be transmission-gtk or transmission. Ensure you use the correct one.
    MimeType: This specifies that this entry will handle magnet links.

Step 3: Update Desktop Database

Run the following command to update the desktop database:

bash

update-desktop-database ~/.local/share/applications

Step 4: Associate Magnet Links with Transmission

You can set the new .desktop entry as the default handler for magnet links. Run this command:

bash

xdg-mime default transmission-magnet.desktop x-scheme-handler/magnet

Step 5: Test the Setup

You can now test it by clicking on a magnet link, or by using the terminal:

bash

xdg-open "magnet:?xt=urn:btih:your_magnet_link_here"

Additional Notes

    Ensure that Transmission is installed on your system.
    If you’re using Transmission with a specific interface (like Transmission-Qt), adjust the Exec line accordingly.
    If you want to customize the icon, replace Icon=transmission with the path to your custom icon file.

By following these steps, your system should now open magnet links with Transmission via xdg-open.
You said:
Would this then automatically execute when clicking a magnet link in the browser?
ChatGPT said:
ChatGPT

Yes, after following the steps to create the .desktop file and associate it with the magnet MIME type, clicking a magnet link in your browser should automatically invoke Transmission to handle that link.
How It Works

    MIME Type Association: By setting xdg-mime default transmission-magnet.desktop x-scheme-handler/magnet, you inform the system that any magnet link (magnet:) should be handled by the transmission-magnet.desktop entry.

    Browser Behavior: Most modern browsers (like Firefox, Chrome, etc.) are designed to open links associated with specific MIME types with the default application set in the desktop environment.

Testing It Out

    Open a Browser: Navigate to a website that provides magnet links.
    Click on a Magnet Link: When you click the link, your system should invoke Transmission automatically.

If It Doesn't Work

If clicking a magnet link does not launch Transmission, you can try the following:

    Browser Settings: Some browsers have settings to manage how certain types of links are handled. Check if the browser settings allow opening magnet links with external applications.
    Check for Errors: Ensure that the .desktop file is correctly configured and that you have updated the desktop database.
    Reboot: Sometimes, a restart can help apply new settings.

Once everything is set up correctly, clicking magnet links should work seamlessly!

'

# Remove existing links and files
for item in "${symlinks[@]}"; do
  target="$HOME/$item"
  if [ -L "$target" ] || [ -f "$target" ]; then
    rm "$target"
    echo ":: Removed existing file/link $target"
  elif [ -d "$target" ]; then
    rm -rf "$target"
    echo ":: Removed existing directory $target"
  fi
done

# Create new symlinks
for item in "${symlinks[@]}"; do
  target="$HOME/$item"
  source="$HOME/$user_dotfiles_dir/$item"
  if [ ! -e "$source" ]; then
    echo "!! Failed to locate file or directory $source"
    sleep 2
    continue
  fi
  ln -sf "$source" "$target"
  echo ":: Created symlink for $target"
done

[[ -d ~/.config/hypr/conf/user ]] && rm ~/.config/hypr/conf/user
ln -s $HOME/$user_dotfiles_dir/.config/hypr/conf/user ~/.config/hypr/conf

if [ $(grep "^source = ~/.config/hypr/conf/user/user.conf" ~/.config/hypr/conf/custom.conf | wc -l) -eq 0 ]; then
  echo "" >>~/.config/hypr/conf/custom.conf # Intentional blank line
  echo "source = ~/.config/hypr/conf/user/user.conf" >>~/.config/hypr/conf/custom.conf
  echo ":: Added user sourcing to hypr conf"
fi
