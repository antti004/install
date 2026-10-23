# 1. Choose your color (e.g., "Navy", "Black", "DarkSlateGray", or custom RGB)
$colorName = "Navy" 
$color = [System.Drawing.Color]::FromName($colorName)

# (Optional alternative for custom RGB):
# $color = [System.Drawing.Color]::FromArgb(20, 30, 40)

# 2. Create a 1x1 pixel image file of that color
$bmp = New-Object System.Drawing.Bitmap 1, 1
$bmp.SetPixel(0, 0, $color)
$path = "$env:TEMP\solid_background.bmp"
$bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Bmp)
$bmp.Dispose()

# 3. Add C# interop to call the Windows API (SystemParametersInfo)
$csharp = @'
using System.Runtime.InteropServices;
public class WallpaperSetter {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
Add-Type -TypeDefinition $csharp -ErrorAction SilentlyContinue

# 4. Set wallpaper style to Stretch (2) so the 1x1 pixel fills the whole screen
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value '2'
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value '0'

# 5. Apply the background image and refresh the desktop
[WallpaperSetter]::SystemParametersInfo(20, 0, $path, 3)