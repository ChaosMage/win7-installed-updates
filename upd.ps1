$wu = new-object -com “Microsoft.Update.Searcher”
 
$totalupdates = $wu.GetTotalHistoryCount()
 
$all = $wu.QueryHistory(0,$totalupdates)

$BadUpdates = Get-Content list.txt | Where {$_ -notmatch '^\s+$'}
 
$res =  @()
             
Foreach ($update in $all)
{
	$string = $update.title
 
	$Regex = “KB\d*”
	$KB = $string | Select-String -Pattern $regex | Select-Object { $_.Matches }
     
	if ($BadUpdates -contains $KB.‘ $_.Matches ‘.Value)
	{
		$res += $string
	}
}

$res = $res | select -uniq

Foreach ($line in $res)
{
	Write-Host $line
}
