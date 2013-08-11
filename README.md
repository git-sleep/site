# git-sleep

## TODOS

* present them with xid and gem installation instructions
* let them set a password...?
* avoid duplicate records caused by token changing slightly all the time
* don't persist their name and photo in case they change? only need to persist xid and token

* deploy
* fix xid / token duplication
* only store xid, don't story token
* change api logic to look up token based on xid
* if we don't have the xid in our system, return json explaining what's up
* round float to a smaller number

* * *

WIP

add `config/application.yml` with this format:

```yml
JAWBONE_SECRET: abcd
JAWBONE_CLIENT_ID: abcd
```