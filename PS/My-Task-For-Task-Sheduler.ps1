
param(
    #[Parameter(Mandatory=$false)][Parameter(Position=0)]
    [String]$TextToPrint = "I love the bootcamp!",
    [uint32]$waitBetweenLines = 120
)

<#
.Synopsis
   Out Char \ Line to Notepad
.DESCRIPTION
   Takes Text and Wait Between Lines Time As Argument
.EXAMPLE
   Out-Notepad $Text $WaitTime (int)
#>
function Out-Notepad
{
  param
  (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)][AllowEmptyString()] 
    [String]$Text,
    [uint32]$waitBetweenLines
  )

  begin
  {
    $sb = New-Object System.Text.StringBuilder
    $process = Start-Process notepad -PassThru -WindowStyle Maximized
    $null = $process.WaitForInputIdle()


    $sig = '
      [DllImport("user32.dll", EntryPoint = "FindWindowEx")]public static extern IntPtr FindWindowEx(IntPtr hwndParent, IntPtr hwndChildAfter, string lpszClass, string lpszWindow);
      [DllImport("User32.dll")]public static extern int SendMessage(IntPtr hWnd, int uMsg, int wParam, string lParam);
    '

    $type = Add-Type -MemberDefinition $sig -Name APISendMessage -PassThru
    $hwnd = $process.MainWindowHandle
    [IntPtr]$child = $type::FindWindowEx($hwnd, [IntPtr]::Zero, "Edit", $null)
  }

  process
  {
    $null = $sb.AppendLine($Text)
    $null = $type::SendMessage($child, 0x000C, 0, $sb.ToString())
    if ($waitBetweenLines -gt 0){
        sleep -Milliseconds $waitBetweenLines
    }
  }
}

#Script Start
$(for ($i = 0; $i -lt $Text.Length; $i++){$TextToPrint[$i]}) | Out-Notepad -waitBetweenLines 120 | Out-String