
def loginterp(x,y,x0):
    n = len(x)
    if x0 < x[0]:
        extra = True
        i = 1
    elif x0 > x[n-1]:
        extra = True
        i = n-1
    else:
        extra = False
        i = 1
        while x[i] < x0:
            i = i + 1

    if (y[i] > 0.) and (y[i-1] > 0.) and (x[i] > 0.) and (x[i-1] > 0.):
        y0 = 10.0** (math.log10(y[i-1]) + (math.log10(y[i])-math.log10(y[i-1])) * (math.log10(x0)-math.log10(x[i-1]))/(math.log10(x[i])-math.log10(x[i-1])) )
    else:
        y0 = y[i-1] + (y[i]-y[i-1]) * (x0-x[i-1])/(x[i]-x[i-1])

    return (y0, extra)

