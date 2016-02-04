import sys
from bs4 import BeautifulSoup

def extract_image_links(filename):
    soup = parse_html_file(filename)
    links = [anchor["href"] for anchor in soup.find_all("a") if anchor.has_attr("href") and anchor["href"].find("/large") >= 0]
    return links

def parse_html_file(filename):
    
    f = open(filename)
    html = f.read()
    f.close()

    soup = BeautifulSoup(html, "html.parser")

    return soup

soup = None
link = ""

def main():
    print "Mii Characters Image URL Scraper"
    
    global soup
    global link 
    
    links = []
    invalid_ids = []

    f=open("image_urls.txt", "w")
    
    for i in range(1,2847):
        
        if i%100==0:
            print i

        folder = i % 10
        link = extract_image_links("html/%s/%s.html" % (folder, i))
        if len(link) == 1:
            links.append(link[0])
            f.write(link[0] + "\n")
        else:
            invalid_ids.append(i)
    
    total = len(links) + len(invalid_ids)
    
    print "Total files analyzed:\t %s" % (total)
    print "               valid:\t %s (%.2f)"   % (len(links), float(len(links))/total)
    print "             invalid:\t %s (%.2f)"   % (len(invalid_ids), float(len(invalid_ids))/total)
    
    f.close()





if __name__ == "__main__":
    main()
