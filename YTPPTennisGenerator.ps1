Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function New-YTPPTennisForm {
    $form = New-Object Windows.Forms.Form
    $form.Text = "YTP Poop Tennis Generator"
    $form.Size = [Drawing.Size]::new(600, 450)
    $form.StartPosition = "CenterScreen"

    # Source Selection
    $lblSource = New-Object Windows.Forms.Label
    $lblSource.Text = "Source Videos"
    $lblSource.Location = [Drawing.Point]::new(10, 10)
    $form.Controls.Add($lblSource)

    $lstSources = New-Object Windows.Forms.ListBox
    $lstSources.Location = [Drawing.Point]::new(10, 30)
    $lstSources.Size = [Drawing.Size]::new(250, 80)
    $form.Controls.Add($lstSources)

    $btnAddSource = New-Object Windows.Forms.Button
    $btnAddSource.Text = "Add Source"
    $btnAddSource.Location = [Drawing.Point]::new(270, 30)
    $btnAddSource.Add_Click({
        $ofd = New-Object Windows.Forms.OpenFileDialog
        $ofd.Multiselect = $true
        $ofd.Filter = "Video Files (*.mp4;*.mkv;*.avi;*.wmv)|*.mp4;*.mkv;*.avi;*.wmv"
        if ($ofd.ShowDialog() -eq "OK") {
            $ofd.FileNames | ForEach-Object { $lstSources.Items.Add($_) }
        }
    })
    $form.Controls.Add($btnAddSource)

    $btnClearSources = New-Object Windows.Forms.Button
    $btnClearSources.Text = "Clear Sources"
    $btnClearSources.Location = [Drawing.Point]::new(270, 60)
    $btnClearSources.Add_Click({ $lstSources.Items.Clear() })
    $form.Controls.Add($btnClearSources)

    # Effect Selection
    $lblEffects = New-Object Windows.Forms.Label
    $lblEffects.Text = "Effects"
    $lblEffects.Location = [Drawing.Point]::new(10, 120)
    $form.Controls.Add($lblEffects)

    $chkReverse = New-Object Windows.Forms.CheckBox
    $chkReverse.Text = "Reverse"
    $chkReverse.Location = [Drawing.Point]::new(10, 140)
    $form.Controls.Add($chkReverse)

    $chkStutter = New-Object Windows.Forms.CheckBox
    $chkStutter.Text = "Stutter"
    $chkStutter.Location = [Drawing.Point]::new(120, 140)
    $form.Controls.Add($chkStutter)

    $chkRainbow = New-Object Windows.Forms.CheckBox
    $chkRainbow.Text = "Rainbow Overlay"
    $chkRainbow.Location = [Drawing.Point]::new(10, 170)
    $form.Controls.Add($chkRainbow)

    $chkMirror = New-Object Windows.Forms.CheckBox
    $chkMirror.Text = "Mirror"
    $chkMirror.Location = [Drawing.Point]::new(120, 170)
    $form.Controls.Add($chkMirror)

    $chkSus = New-Object Windows.Forms.CheckBox
    $chkSus.Text = "Sus Effect"
    $chkSus.Location = [Drawing.Point]::new(10, 200)
    $form.Controls.Add($chkSus)

    # Tennis Settings
    $lblTennis = New-Object Windows.Forms.Label
    $lblTennis.Text = "YTP Tennis Settings"
    $lblTennis.Location = [Drawing.Point]::new(10, 230)
    $form.Controls.Add($lblTennis)

    $lblRounds = New-Object Windows.Forms.Label
    $lblRounds.Text = "Rounds:"
    $lblRounds.Location = [Drawing.Point]::new(10, 250)
    $form.Controls.Add($lblRounds)
    
    $nudRounds = New-Object Windows.Forms.NumericUpDown
    $nudRounds.Location = [Drawing.Point]::new(60, 248)
    $nudRounds.Minimum = 1
    $nudRounds.Maximum = 10
    $nudRounds.Value = 2
    $form.Controls.Add($nudRounds)

    $btnRender = New-Object Windows.Forms.Button
    $btnRender.Text = "Render"
    $btnRender.Location = [Drawing.Point]::new(10, 320)
    $btnRender.Add_Click({
        # Placeholder - actual rendering logic using ffmpeg and selected effects
        $sources = @()
        foreach ($item in $lstSources.Items) { $sources += $item }
        $effects = @{
            Reverse = $chkReverse.Checked
            Stutter = $chkStutter.Checked
            Rainbow = $chkRainbow.Checked
            Mirror = $chkMirror.Checked
            Sus = $chkSus.Checked
        }
        $rounds = $nudRounds.Value

        [Windows.Forms.MessageBox]::Show(
            "Render started.`nSources: $($sources.Count)`nRounds: $rounds`nEffects: $($effects | Out-String)",
            "YTPPTennisGenerator"
        )

        # Implement your actual logic for tennis passing, effects application, output file creation here
    })
    $form.Controls.Add($btnRender)

    $form.ShowDialog()
}

New-YTPPTennisForm