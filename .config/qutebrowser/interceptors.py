import operator, re, typing
from urllib.parse import urljoin
from os.path import expanduser

from qutebrowser.api import interceptor, message
from PyQt5.QtCore import QUrl

def _wiki_redir(url: QUrl) -> bool:
    p = url.path()
    if p.startswith("/wiki/"):
        url.setPath(urljoin("/info/", p.lstrip("/wiki/")))
        url.setHost("infogalactic.com")
        return True
    return False

with open(expanduser('~/.cache/best-instances/invidious.txt')) as f:
    best_invidious = f.readline().strip()

# Any return value other than a literal 'False' means we redirected
REDIRECT_MAP = {
    "reddit.com": operator.methodcaller('setHost', 'teddit.net'),
    "youtube.com": operator.methodcaller('setHost', best_invidious),
    "instagram.com": operator.methodcaller('setHost', "bibliogram.art"),
    "twitter.com": operator.methodcaller('setHost', "nitter.42l.fr"),
    "en.wikipedia.org": _wiki_redir,
} # type: typing.Dict[str, typing.Callable[..., typing.Optional[bool]]]

def int_fn(info: interceptor.Request):
    # """Block the given request if necessary."""
    # if (info.resource_type != interceptor.ResourceType.main_frame or
    #               info.request_url.scheme() in {"data", "blob"}):
    #       return
    url = info.request_url
    redir = REDIRECT_MAP.get(url.host().lstrip("www."))
    if redir is not None and redir(url) is not False:
        message.info("Redirecting to " + url.toString())
        info.redirect(url)


interceptor.register(int_fn)
