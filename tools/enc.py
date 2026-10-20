def rle_opt(data, minrun=2):
    n=len(data)
    INF=1<<30
    dp=[INF]*(n+1); nxt=[(0,0)]*(n+1); dp[n]=1  # terminator
    for i in range(n-1,-1,-1):
        # literal runs
        L=1
        best=INF; besto=None
        while L<=127 and i+L<=n:
            c=1+L+dp[i+L]
            if c<best: best=c; besto=('lit',L)
            L+=1
        # repeat
        if True:
            v=data[i]; L=0
            while L<127 and i+L<n and data[i+L]==v:
                L+=1
                if L>=minrun:
                    c=2+dp[i+L]
                    if c<best: best=c; besto=('rep',L)
        dp[i]=best; nxt[i]=besto
    out=bytearray(); i=0
    while i<n:
        kind,L=nxt[i]
        if kind=='lit': out.append(L); out.extend(data[i:i+L])
        else: out.append(0x80|L); out.append(data[i])
        i+=L
    out.append(0)
    return bytes(out)
