try:

    import requests
    import json

except Exception as e:
    print("Some Modules are Missing {}".format(e))


class WebCrawler(object):

    def __init__(self, data, sl, tl):
        self._headers = {'User-Agent': "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"}
        self._base_url = "https://translate.googleapis.com/translate_a/single"
        self.data = data
        self.params = {
            "client": "gtx",
            "sl": sl,
            "tl": tl,
            "dt": "t",
            "q": self.data}

    @property
    def get(self):
        try:

            r = requests.get(url=self._base_url,
                             headers=self._headers,
                             params=self.params)

            data = r.json()
            return data[0][0][0]

        except Exception as e :
            print("Failed to Make Response  {}".format(e))

class EngtoHindi(object):

    def __init__(self, message):
        self.message = message
        self._crawler  = WebCrawler(data=self.message, sl="en", tl="hi")

    @property
    def convert(self):
        return self._crawler.get


class HindiToEng(object):

    def __init__(self, message):
        self.message = message
        self._crawler  = WebCrawler(data=self.message, sl="hi", tl="en")

    @property
    def convert(self):
        return self._crawler.get