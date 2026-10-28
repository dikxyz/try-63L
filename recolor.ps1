$p = 'style.css'
$c = Get-Content -LiteralPath $p -Raw
$pairs = @(
  @(':root{--yellow:#d4a017;--yellow-dark:#a67c00;--red:#B94A48;--red-dark:#8B2F2F;--ink:#202020;--muted:#6e6a67;--paper:#f6f3ef;--white:#fff;--line:#ded8d1;--radius:18px}', ':root{--accent:#0598CE;--accent-2:#3B82F6;--accent-soft:#6EC6F0;--red:#0598CE;--red-dark:#3B82F6;--ink:#E6EDF3;--muted:#8B949E;--paper:#001A33;--white:#0D1117;--line:#30363D;--radius:18px;--surface:#0D1117;--band:#001426}'),
  @('background:rgba(246,243,239,.96);backdrop-filter:blur(14px);border-bottom:1px solid rgba(32,32,32,.1)', 'background:rgba(0,18,36,.92);backdrop-filter:blur(14px);border-bottom:1px solid rgba(230,237,243,.08)'),
  @('.desktop-nav>a:not(.nav-cta):hover{color:var(--yellow)}', '.desktop-nav>a:not(.nav-cta):hover{color:var(--accent-soft)}'),
  @('.nav-cta{background:var(--yellow);color:white;', '.nav-cta{background:var(--accent);color:white;'),
  @('.hero{position:relative;background:var(--red);color:white;overflow:hidden}', '.hero{position:relative;background:radial-gradient(120% 90% at 85% 0%,#06294a 0%,#001A33 55%,#00121f 100%);color:#E6EDF3;overflow:hidden}'),
  @('.hero:before{content:"";position:absolute;inset:0;background:linear-gradient(105deg,rgba(92,12,17,.34),transparent 58%),linear-gradient(to top,rgba(46,8,10,.24),transparent 42%),radial-gradient(circle at 10% 100%,rgba(25,10,10,.2),transparent 45%);pointer-events:none}', '.hero:before{content:"";position:absolute;inset:0;background:radial-gradient(circle at 12% 88%,rgba(5,152,206,.20),transparent 46%),radial-gradient(circle at 90% 10%,rgba(59,130,246,.16),transparent 42%),linear-gradient(to top,rgba(0,8,16,.35),transparent 45%);pointer-events:none}'),
  @('background:#f5c5bc;display:inline-block', 'background:var(--accent);display:inline-block'),
  @('.button-light{background:#fff;color:var(--red-dark)}', '.button-light{background:var(--accent);color:#fff}'),
  @('.button-light:hover{background:#f7ded8}', '.button-light:hover{background:var(--accent-2)}'),
  @('border:1px solid rgba(255,255,255,.5);z-index:0', 'border:1px solid rgba(110,198,240,.4);z-index:0'),
  @('.photo-tag{position:absolute;z-index:2;bottom:42px;left:-22px;background:#fff;color:var(--ink);padding:16px 20px;', '.photo-tag{position:absolute;z-index:2;bottom:42px;left:-22px;background:#0D1117;border:1px solid #30363D;padding:16px 20px;'),
  @('.services{background:#e9e4dd}', '.services{background:#001A33}'),
  @('.service-card{min-height:300px;background:#fbfaf8;padding:22px;display:flex;flex-direction:column;border-top:3px solid var(--red);', '.service-card{min-height:300px;background:#0D1117;border:1px solid #30363D;padding:22px;display:flex;flex-direction:column;border-top:3px solid var(--accent);'),
  @('.service-card-dark{background:var(--ink);color:white}', '.service-card-dark{background:linear-gradient(150deg,var(--accent),var(--accent-2));color:#fff}'),
  @('.service-card-dark .service-link{border-color:#4a4847}', '.service-card-dark .service-link{border-color:rgba(255,255,255,.4);color:#fff}'),
  @('.workshop{background:#fff;display:grid', '.workshop{background:var(--band);display:grid'),
  @('.contact{background:#252322;color:white;', '.contact{background:#001020;color:#E6EDF3;'),
  @('.contact-form{background:#fff;color:var(--ink);padding:30px;border-radius:3px;box-shadow:0 25px 60px #0002}', '.contact-form{background:#0D1117;border:1px solid #30363D;padding:30px;border-radius:3px;box-shadow:0 25px 60px #00000066}'),
  @('.products{background:#fff}', '.products{background:var(--band)}'),
  @('.product-card{background:#fbfaf8;border:1px solid var(--line);border-top:3px solid var(--red);', '.product-card{background:#0D1117;border:1px solid #30363D;border-top:3px solid var(--accent);'),
  @('overflow:hidden;background:#e9e4dd}', 'overflow:hidden;background:#001830}'),
  @('.product-badge{position:absolute;left:12px;top:12px;background:#fff;color:var(--red);', '.product-badge{position:absolute;left:12px;top:12px;background:var(--accent);color:#fff;'),
  @('.footer-brand img{width:45px;height:45px;object-fit:contain;background:#fff;border-radius:50%}', '.footer-brand img{width:45px;height:45px;object-fit:contain;background:transparent;border-radius:10px}'),
  @('background:#1d8c55;color:#fff;border-radius:30px', 'background:var(--accent);color:#fff;border-radius:30px'),
  @('border:0;background:#fff;color:var(--red);font-size:19px;box-shadow:0 5px 20px #0002', 'border:1px solid #30363D;background:#0D1117;color:var(--accent);font-size:19px;box-shadow:0 5px 20px #00000055'),
  @('.nav-cta,.mobile-nav .mobile-nav-cta,.button-light,.submit-button{background:#25D366;color:#fff}', '.nav-cta,.mobile-nav .mobile-nav-cta,.button-light,.submit-button{background:var(--accent);color:#fff}'),
  @('.nav-cta:hover,.mobile-nav .mobile-nav-cta:hover,.button-light:hover,.submit-button:hover{background:#1ebe5d;color:#fff}', '.nav-cta:hover,.mobile-nav .mobile-nav-cta:hover,.button-light:hover,.submit-button:hover{background:var(--accent-2);color:#fff}'),
  @('border-bottom:1px solid #d9aaa4', 'border-bottom:1px solid rgba(110,198,240,.45)'),
  @('border:1px solid #d9d0c8', 'border:1px solid #30363D')
)
$pairs += @(
  @('#ffc5b9', 'var(--accent-soft)'),
  @('#f0aaa0', 'var(--accent-soft)'),
  @('#e9a29a', 'var(--accent-soft)'),
  @('#e8aaa2', 'var(--accent-soft)'),
  @('#c5bfba', 'var(--muted)'),
  @('#b4aaa5', '#8B949E'),
  @('#c4c0bd', 'rgba(255,255,255,.88)'),
  @('#9d9690', '#8B949E'),
  @('#716c66', '#8B949E'),
  @('#5f5b57', 'var(--muted)'),
  @('#4a4847', 'rgba(255,255,255,.4)'),
  @('#494441', '#30363D'),
  @('#5b5350', '#30363D'),
  @('#e6e1dc', '#30363D'),
  @('#e2ddd7', '#30363D'),
  @('#f9f8f6', '#001830'),
  @('#393634', '#30363D'),
  @('#8e8781', '#8B949E'),
  @('#aaa39d', '#8B949E'),
  @('#a7a09a', '#8B949E'),
  @('color:#777', 'color:#8B949E'),
  @('#191817', '#000B16'),
  @('#e5ddd5', '#30363D'),
  @('#b72f3212', '#0598CE33'),
  @('#4a111540', '#00000080'),
  @('#2a20140f', '#00000066'),
  @('#32101030', '#00000066'),
  @('#fbfaf8', '#0D1117')
)
$miss = New-Object System.Collections.Generic.List[string]
foreach ($pr in $pairs) {
  if ($c.Contains($pr[0])) { $c = $c.Replace($pr[0], $pr[1]) } else { $miss.Add($pr[0]) }
}
$c += "`n.service-card-dark .service-top{color:rgba(255,255,255,.8)}.service-card-dark .service-symbol{color:#fff}.service-card-dark h3{color:#fff}.contact-form select option{background:#0D1117;color:#E6EDF3}::selection{background:rgba(5,152,206,.4);color:#fff}`n"
Set-Content -LiteralPath $p -Value $c -NoNewline -Encoding utf8
if ($miss.Count) { Write-Output 'MISSING:'; $miss | ForEach-Object { Write-Output (' - ' + $_) } } else { Write-Output 'ALL APPLIED' }