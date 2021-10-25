# https://www.hackerrank.com/challenges/designer-pdf-viewer/problem?isFullScreen=false


# Score 20.0 for python
print(ord('w') - ord('a'))
def designerPdfViewer(h, word):
    # Write your code here
    max_heigh = 0
    for w in word:
        max_heigh = max(max_heigh, h[ord(w) - ord('a')])
    return max_heigh * len(word)