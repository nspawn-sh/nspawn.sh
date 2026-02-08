Reference: https://android.googlesource.com/platform/system/netd/+/refs/heads/main/server/NdcDispatcher.cpp

---

# ndc — Netd Control Command Reference

```
ndc <command> [subcommand] [arguments...]
```

---

## interface

```
ndc interface list
ndc interface getcfg <iface>
ndc interface setcfg <iface> [<ipv4addr> <prefixLen>] [up|down]
ndc interface clearaddrs <iface>
ndc interface ipv6privacyextensions <iface> <enable|disable>
ndc interface ipv6 <iface> <enable|disable>
ndc interface setmtu <iface> <mtu>
```

Notes:

* Flags supported in `setcfg`: `up`, `down`
* Other flags are parsed but ignored: `broadcast`, `multicast`, `running`, `loopback`, `point-to-point`

---

## ipfwd

```
ndc ipfwd status
ndc ipfwd enable <requester>
ndc ipfwd disable <requester>
ndc ipfwd add <inIface> <outIface>
ndc ipfwd remove <inIface> <outIface>
```

---

## tether

```
ndc tether start <dhcpStart> <dhcpEnd> [<dhcpStart> <dhcpEnd>]...
ndc tether stop
ndc tether status

ndc tether interface add <iface>
ndc tether interface remove <iface>
ndc tether interface list

ndc tether dns set <netId> <dns1> [dns2]...
```

---

## nat

```
ndc nat enable <intIface> <extIface>
ndc nat disable <intIface> <extIface>
```

---

## bandwidth

```
ndc bandwidth setiquota <iface> <bytes>
ndc bandwidth removeiquota <iface>

ndc bandwidth setinterfacealert <iface> <bytes>
ndc bandwidth removeinterfacealert <iface>
ndc bandwidth setglobalalert <bytes>

ndc bandwidth addnaughtyapps <uid>...
ndc bandwidth removenaughtyapps <uid>...

ndc bandwidth addniceapps <uid>...
ndc bandwidth removeniceapps <uid>...
```

Aliases supported:

```
setiquota          siq
removeiquota       riq
addnaughtyapps     ana
removenaughtyapps  rna
addniceapps        aha
removeniceapps     rha
setglobalalert     sga
setinterfacealert  sia
removeinterfacealert ria
```

---

## idletimer

```
ndc idletimer add <iface> <timeoutSec> <label>
ndc idletimer remove <iface> <timeoutSec> <label>
```

---

## firewall

```
ndc firewall enable <allowlist|denylist>

ndc firewall set_interface_rule <iface> <allow|deny>

ndc firewall set_uid_rule <dozable|standby|powersave|restricted|none> <uid> <allow|deny>

ndc firewall enable_chain <dozable|standby|powersave|restricted>
ndc firewall disable_chain <dozable|standby|powersave|restricted>
```

---

## strict

```
ndc strict set_uid_cleartext_policy <uid> <accept|log|reject>
```

---

## network

### network create / destroy

```
ndc network create <netId> [NETWORK|SYSTEM]
ndc network create <netId> vpn <0|1>
ndc network destroy <netId>
```

---

### network interface

```
ndc network interface add <netId> <iface>
ndc network interface remove <netId> <iface>
```

---

### network route

```
ndc network route add <netId> <iface> <destination> [nexthop]
ndc network route remove <netId> <iface> <destination> [nexthop]

ndc network route legacy <uid> add <netId> <iface> <destination> [nexthop]
ndc network route legacy <uid> remove <netId> <iface> <destination> [nexthop]
```

`nexthop` may be:

* IPv4 / IPv6 address
* `unreachable`
* `throw`

---

### network default

```
ndc network default set <netId>
ndc network default clear
```

---

### network permission

```
ndc network permission user set <NETWORK|SYSTEM> <uid>...
ndc network permission user clear <uid>...

ndc network permission network set <NETWORK|SYSTEM> <netId>...
ndc network permission network clear <netId>...
```

---

### network users

```
ndc network users add <netId> <uid>[-<uid>]...
ndc network users remove <netId> <uid>[-<uid>]...
```

---

### network protect

```
ndc network protect allow <uid>...
ndc network protect deny <uid>...
```

---

## Valid netId formats

```
<number>
local
oem1 .. oem50
handle<netHandle>
```

---

## Notes on access

* Most commands require **SYSTEM / NETWORK permission**
* Vendor binaries can only execute **whitelisted ndc commands** via `NetUtilsWrapper`
* `ndc` is **not stable ABI**; it is an internal control plane
