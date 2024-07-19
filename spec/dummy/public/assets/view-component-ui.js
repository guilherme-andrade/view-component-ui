var le = {
  logger: typeof console < "u" ? console : void 0,
  WebSocket: typeof WebSocket < "u" ? WebSocket : void 0
}, g = {
  log(...e) {
    this.enabled && (e.push(Date.now()), le.logger.log("[ActionCable]", ...e));
  }
};
const J = () => (/* @__PURE__ */ new Date()).getTime(), ae = (e) => (J() - e) / 1e3;
class Ye {
  constructor(t) {
    this.visibilityDidChange = this.visibilityDidChange.bind(this), this.connection = t, this.reconnectAttempts = 0;
  }
  start() {
    this.isRunning() || (this.startedAt = J(), delete this.stoppedAt, this.startPolling(), addEventListener("visibilitychange", this.visibilityDidChange), g.log(`ConnectionMonitor started. stale threshold = ${this.constructor.staleThreshold} s`));
  }
  stop() {
    this.isRunning() && (this.stoppedAt = J(), this.stopPolling(), removeEventListener("visibilitychange", this.visibilityDidChange), g.log("ConnectionMonitor stopped"));
  }
  isRunning() {
    return this.startedAt && !this.stoppedAt;
  }
  recordPing() {
    this.pingedAt = J();
  }
  recordConnect() {
    this.reconnectAttempts = 0, this.recordPing(), delete this.disconnectedAt, g.log("ConnectionMonitor recorded connect");
  }
  recordDisconnect() {
    this.disconnectedAt = J(), g.log("ConnectionMonitor recorded disconnect");
  }
  startPolling() {
    this.stopPolling(), this.poll();
  }
  stopPolling() {
    clearTimeout(this.pollTimeout);
  }
  poll() {
    this.pollTimeout = setTimeout(() => {
      this.reconnectIfStale(), this.poll();
    }, this.getPollInterval());
  }
  getPollInterval() {
    const { staleThreshold: t, reconnectionBackoffRate: n } = this.constructor, r = Math.pow(1 + n, Math.min(this.reconnectAttempts, 10)), o = (this.reconnectAttempts === 0 ? 1 : n) * Math.random();
    return t * 1e3 * r * (1 + o);
  }
  reconnectIfStale() {
    this.connectionIsStale() && (g.log(`ConnectionMonitor detected stale connection. reconnectAttempts = ${this.reconnectAttempts}, time stale = ${ae(this.refreshedAt)} s, stale threshold = ${this.constructor.staleThreshold} s`), this.reconnectAttempts++, this.disconnectedRecently() ? g.log(`ConnectionMonitor skipping reopening recent disconnect. time disconnected = ${ae(this.disconnectedAt)} s`) : (g.log("ConnectionMonitor reopening"), this.connection.reopen()));
  }
  get refreshedAt() {
    return this.pingedAt ? this.pingedAt : this.startedAt;
  }
  connectionIsStale() {
    return ae(this.refreshedAt) > this.constructor.staleThreshold;
  }
  disconnectedRecently() {
    return this.disconnectedAt && ae(this.disconnectedAt) < this.constructor.staleThreshold;
  }
  visibilityDidChange() {
    document.visibilityState === "visible" && setTimeout(() => {
      (this.connectionIsStale() || !this.connection.isOpen()) && (g.log(`ConnectionMonitor reopening stale connection on visibilitychange. visibilityState = ${document.visibilityState}`), this.connection.reopen());
    }, 200);
  }
}
Ye.staleThreshold = 6;
Ye.reconnectionBackoffRate = 0.15;
var Ot = {
  message_types: {
    welcome: "welcome",
    disconnect: "disconnect",
    ping: "ping",
    confirmation: "confirm_subscription",
    rejection: "reject_subscription"
  },
  disconnect_reasons: {
    unauthorized: "unauthorized",
    invalid_request: "invalid_request",
    server_restart: "server_restart",
    remote: "remote"
  },
  default_mount_path: "/cable",
  protocols: ["actioncable-v1-json", "actioncable-unsupported"]
};
const { message_types: U, protocols: Re } = Ot, Yn = Re.slice(0, Re.length - 1), mt = [].indexOf;
class Xe {
  constructor(t) {
    this.open = this.open.bind(this), this.consumer = t, this.subscriptions = this.consumer.subscriptions, this.monitor = new Ye(this), this.disconnected = !0;
  }
  send(t) {
    return this.isOpen() ? (this.webSocket.send(JSON.stringify(t)), !0) : !1;
  }
  open() {
    if (this.isActive())
      return g.log(`Attempted to open WebSocket, but existing socket is ${this.getState()}`), !1;
    {
      const t = [...Re, ...this.consumer.subprotocols || []];
      return g.log(`Opening WebSocket, current state is ${this.getState()}, subprotocols: ${t}`), this.webSocket && this.uninstallEventHandlers(), this.webSocket = new le.WebSocket(this.consumer.url, t), this.installEventHandlers(), this.monitor.start(), !0;
    }
  }
  close({ allowReconnect: t } = {
    allowReconnect: !0
  }) {
    if (t || this.monitor.stop(), this.isOpen())
      return this.webSocket.close();
  }
  reopen() {
    if (g.log(`Reopening WebSocket, current state is ${this.getState()}`), this.isActive())
      try {
        return this.close();
      } catch (t) {
        g.log("Failed to reopen WebSocket", t);
      } finally {
        g.log(`Reopening WebSocket in ${this.constructor.reopenDelay}ms`), setTimeout(this.open, this.constructor.reopenDelay);
      }
    else
      return this.open();
  }
  getProtocol() {
    if (this.webSocket)
      return this.webSocket.protocol;
  }
  isOpen() {
    return this.isState("open");
  }
  isActive() {
    return this.isState("open", "connecting");
  }
  triedToReconnect() {
    return this.monitor.reconnectAttempts > 0;
  }
  isProtocolSupported() {
    return mt.call(Yn, this.getProtocol()) >= 0;
  }
  isState(...t) {
    return mt.call(t, this.getState()) >= 0;
  }
  getState() {
    if (this.webSocket) {
      for (let t in le.WebSocket)
        if (le.WebSocket[t] === this.webSocket.readyState)
          return t.toLowerCase();
    }
    return null;
  }
  installEventHandlers() {
    for (let t in this.events) {
      const n = this.events[t].bind(this);
      this.webSocket[`on${t}`] = n;
    }
  }
  uninstallEventHandlers() {
    for (let t in this.events)
      this.webSocket[`on${t}`] = function() {
      };
  }
}
Xe.reopenDelay = 500;
Xe.prototype.events = {
  message(e) {
    if (!this.isProtocolSupported())
      return;
    const { identifier: t, message: n, reason: r, reconnect: i, type: o } = JSON.parse(e.data);
    switch (o) {
      case U.welcome:
        return this.triedToReconnect() && (this.reconnectAttempted = !0), this.monitor.recordConnect(), this.subscriptions.reload();
      case U.disconnect:
        return g.log(`Disconnecting. Reason: ${r}`), this.close({
          allowReconnect: i
        });
      case U.ping:
        return this.monitor.recordPing();
      case U.confirmation:
        return this.subscriptions.confirmSubscription(t), this.reconnectAttempted ? (this.reconnectAttempted = !1, this.subscriptions.notify(t, "connected", {
          reconnected: !0
        })) : this.subscriptions.notify(t, "connected", {
          reconnected: !1
        });
      case U.rejection:
        return this.subscriptions.reject(t);
      default:
        return this.subscriptions.notify(t, "received", n);
    }
  },
  open() {
    if (g.log(`WebSocket onopen event, using '${this.getProtocol()}' subprotocol`), this.disconnected = !1, !this.isProtocolSupported())
      return g.log("Protocol is unsupported. Stopping monitor and disconnecting."), this.close({
        allowReconnect: !1
      });
  },
  close(e) {
    if (g.log("WebSocket onclose event"), !this.disconnected)
      return this.disconnected = !0, this.monitor.recordDisconnect(), this.subscriptions.notifyAll("disconnected", {
        willAttemptReconnect: this.monitor.isRunning()
      });
  },
  error() {
    g.log("WebSocket onerror event");
  }
};
const Xn = function(e, t) {
  if (t != null)
    for (let n in t) {
      const r = t[n];
      e[n] = r;
    }
  return e;
};
class Qn {
  constructor(t, n = {}, r) {
    this.consumer = t, this.identifier = JSON.stringify(n), Xn(this, r);
  }
  perform(t, n = {}) {
    return n.action = t, this.send(n);
  }
  send(t) {
    return this.consumer.send({
      command: "message",
      identifier: this.identifier,
      data: JSON.stringify(t)
    });
  }
  unsubscribe() {
    return this.consumer.subscriptions.remove(this);
  }
}
class Zn {
  constructor(t) {
    this.subscriptions = t, this.pendingSubscriptions = [];
  }
  guarantee(t) {
    this.pendingSubscriptions.indexOf(t) == -1 ? (g.log(`SubscriptionGuarantor guaranteeing ${t.identifier}`), this.pendingSubscriptions.push(t)) : g.log(`SubscriptionGuarantor already guaranteeing ${t.identifier}`), this.startGuaranteeing();
  }
  forget(t) {
    g.log(`SubscriptionGuarantor forgetting ${t.identifier}`), this.pendingSubscriptions = this.pendingSubscriptions.filter((n) => n !== t);
  }
  startGuaranteeing() {
    this.stopGuaranteeing(), this.retrySubscribing();
  }
  stopGuaranteeing() {
    clearTimeout(this.retryTimeout);
  }
  retrySubscribing() {
    this.retryTimeout = setTimeout(() => {
      this.subscriptions && typeof this.subscriptions.subscribe == "function" && this.pendingSubscriptions.map((t) => {
        g.log(`SubscriptionGuarantor resubscribing ${t.identifier}`), this.subscriptions.subscribe(t);
      });
    }, 500);
  }
}
class er {
  constructor(t) {
    this.consumer = t, this.guarantor = new Zn(this), this.subscriptions = [];
  }
  create(t, n) {
    const r = t, i = typeof r == "object" ? r : {
      channel: r
    }, o = new Qn(this.consumer, i, n);
    return this.add(o);
  }
  add(t) {
    return this.subscriptions.push(t), this.consumer.ensureActiveConnection(), this.notify(t, "initialized"), this.subscribe(t), t;
  }
  remove(t) {
    return this.forget(t), this.findAll(t.identifier).length || this.sendCommand(t, "unsubscribe"), t;
  }
  reject(t) {
    return this.findAll(t).map((n) => (this.forget(n), this.notify(n, "rejected"), n));
  }
  forget(t) {
    return this.guarantor.forget(t), this.subscriptions = this.subscriptions.filter((n) => n !== t), t;
  }
  findAll(t) {
    return this.subscriptions.filter((n) => n.identifier === t);
  }
  reload() {
    return this.subscriptions.map((t) => this.subscribe(t));
  }
  notifyAll(t, ...n) {
    return this.subscriptions.map((r) => this.notify(r, t, ...n));
  }
  notify(t, n, ...r) {
    let i;
    return typeof t == "string" ? i = this.findAll(t) : i = [t], i.map((o) => typeof o[n] == "function" ? o[n](...r) : void 0);
  }
  subscribe(t) {
    this.sendCommand(t, "subscribe") && this.guarantor.guarantee(t);
  }
  confirmSubscription(t) {
    g.log(`Subscription confirmed ${t}`), this.findAll(t).map((n) => this.guarantor.forget(n));
  }
  sendCommand(t, n) {
    const { identifier: r } = t;
    return this.consumer.send({
      command: n,
      identifier: r
    });
  }
}
class tr {
  constructor(t) {
    this._url = t, this.subscriptions = new er(this), this.connection = new Xe(this), this.subprotocols = [];
  }
  get url() {
    return nr(this._url);
  }
  send(t) {
    return this.connection.send(t);
  }
  connect() {
    return this.connection.open();
  }
  disconnect() {
    return this.connection.close({
      allowReconnect: !1
    });
  }
  ensureActiveConnection() {
    if (!this.connection.isActive())
      return this.connection.open();
  }
  addSubProtocol(t) {
    this.subprotocols = [...this.subprotocols, t];
  }
}
function nr(e) {
  if (typeof e == "function" && (e = e()), e && !/^wss?:/i.test(e)) {
    const t = document.createElement("a");
    return t.href = e, t.href = t.href, t.protocol = t.protocol.replace("http", "ws"), t.href;
  } else
    return e;
}
function rr(e = ir("url") || Ot.default_mount_path) {
  return new tr(e);
}
function ir(e) {
  const t = document.head.querySelector(`meta[name='action-cable-${e}']`);
  if (t)
    return t.getAttribute("content");
}
const or = rr();
or.subscriptions.create(
  { channel: "ViewComponentUI::CompilerChannel" },
  {
    received: () => {
      console.log("[INFO] Received a message from compiler channel"), location.reload();
    },
    connected: () => {
      console.log("[INFO] Connected to the compiler channel");
    }
  }
);
var Ie = !1, je = !1, k = [], ke = -1;
function sr(e) {
  cr(e);
}
function cr(e) {
  k.includes(e) || k.push(e), ar();
}
function Mt(e) {
  let t = k.indexOf(e);
  t !== -1 && t > ke && k.splice(t, 1);
}
function ar() {
  !je && !Ie && (Ie = !0, queueMicrotask(ur));
}
function ur() {
  Ie = !1, je = !0;
  for (let e = 0; e < k.length; e++)
    k[e](), ke = e;
  k.length = 0, ke = -1, je = !1;
}
var W, z, ne, Tt, Ne = !0;
function lr(e) {
  Ne = !1, e(), Ne = !0;
}
function fr(e) {
  W = e.reactive, ne = e.release, z = (t) => e.effect(t, { scheduler: (n) => {
    Ne ? sr(n) : n();
  } }), Tt = e.raw;
}
function yt(e) {
  z = e;
}
function dr(e) {
  let t = () => {
  };
  return [(r) => {
    let i = z(r);
    return e._x_effects || (e._x_effects = /* @__PURE__ */ new Set(), e._x_runEffects = () => {
      e._x_effects.forEach((o) => o());
    }), e._x_effects.add(i), t = () => {
      i !== void 0 && (e._x_effects.delete(i), ne(i));
    }, i;
  }, () => {
    t();
  }];
}
var Pt = [], $t = [], Rt = [];
function pr(e) {
  Rt.push(e);
}
function It(e, t) {
  typeof t == "function" ? (e._x_cleanups || (e._x_cleanups = []), e._x_cleanups.push(t)) : (t = e, $t.push(t));
}
function hr(e) {
  Pt.push(e);
}
function _r(e, t, n) {
  e._x_attributeCleanups || (e._x_attributeCleanups = {}), e._x_attributeCleanups[t] || (e._x_attributeCleanups[t] = []), e._x_attributeCleanups[t].push(n);
}
function jt(e, t) {
  e._x_attributeCleanups && Object.entries(e._x_attributeCleanups).forEach(([n, r]) => {
    (t === void 0 || t.includes(n)) && (r.forEach((i) => i()), delete e._x_attributeCleanups[n]);
  });
}
var Qe = new MutationObserver(nt), Ze = !1;
function et() {
  Qe.observe(document, { subtree: !0, childList: !0, attributes: !0, attributeOldValue: !0 }), Ze = !0;
}
function kt() {
  gr(), Qe.disconnect(), Ze = !1;
}
var X = [], Me = !1;
function gr() {
  X = X.concat(Qe.takeRecords()), X.length && !Me && (Me = !0, queueMicrotask(() => {
    br(), Me = !1;
  }));
}
function br() {
  nt(X), X.length = 0;
}
function v(e) {
  if (!Ze)
    return e();
  kt();
  let t = e();
  return et(), t;
}
var tt = !1, de = [];
function mr() {
  tt = !0;
}
function yr() {
  tt = !1, nt(de), de = [];
}
function nt(e) {
  if (tt) {
    de = de.concat(e);
    return;
  }
  let t = [], n = [], r = /* @__PURE__ */ new Map(), i = /* @__PURE__ */ new Map();
  for (let o = 0; o < e.length; o++)
    if (!e[o].target._x_ignoreMutationObserver && (e[o].type === "childList" && (e[o].addedNodes.forEach((s) => s.nodeType === 1 && t.push(s)), e[o].removedNodes.forEach((s) => s.nodeType === 1 && n.push(s))), e[o].type === "attributes")) {
      let s = e[o].target, c = e[o].attributeName, a = e[o].oldValue, u = () => {
        r.has(s) || r.set(s, []), r.get(s).push({ name: c, value: s.getAttribute(c) });
      }, l = () => {
        i.has(s) || i.set(s, []), i.get(s).push(c);
      };
      s.hasAttribute(c) && a === null ? u() : s.hasAttribute(c) ? (l(), u()) : l();
    }
  i.forEach((o, s) => {
    jt(s, o);
  }), r.forEach((o, s) => {
    Pt.forEach((c) => c(s, o));
  });
  for (let o of n)
    if (!t.includes(o) && ($t.forEach((s) => s(o)), o._x_cleanups))
      for (; o._x_cleanups.length; )
        o._x_cleanups.pop()();
  t.forEach((o) => {
    o._x_ignoreSelf = !0, o._x_ignore = !0;
  });
  for (let o of t)
    n.includes(o) || o.isConnected && (delete o._x_ignoreSelf, delete o._x_ignore, Rt.forEach((s) => s(o)), o._x_ignore = !0, o._x_ignoreSelf = !0);
  t.forEach((o) => {
    delete o._x_ignoreSelf, delete o._x_ignore;
  }), t = null, n = null, r = null, i = null;
}
function Nt(e) {
  return ie(B(e));
}
function re(e, t, n) {
  return e._x_dataStack = [t, ...B(n || e)], () => {
    e._x_dataStack = e._x_dataStack.filter((r) => r !== t);
  };
}
function B(e) {
  return e._x_dataStack ? e._x_dataStack : typeof ShadowRoot == "function" && e instanceof ShadowRoot ? B(e.host) : e.parentNode ? B(e.parentNode) : [];
}
function ie(e) {
  let t = new Proxy({}, {
    ownKeys: () => Array.from(new Set(e.flatMap((n) => Object.keys(n)))),
    has: (n, r) => e.some((i) => i.hasOwnProperty(r)),
    get: (n, r) => (e.find((i) => {
      if (i.hasOwnProperty(r)) {
        let o = Object.getOwnPropertyDescriptor(i, r);
        if (o.get && o.get._x_alreadyBound || o.set && o.set._x_alreadyBound)
          return !0;
        if ((o.get || o.set) && o.enumerable) {
          let s = o.get, c = o.set, a = o;
          s = s && s.bind(t), c = c && c.bind(t), s && (s._x_alreadyBound = !0), c && (c._x_alreadyBound = !0), Object.defineProperty(i, r, {
            ...a,
            get: s,
            set: c
          });
        }
        return !0;
      }
      return !1;
    }) || {})[r],
    set: (n, r, i) => {
      let o = e.find((s) => s.hasOwnProperty(r));
      return o ? o[r] = i : e[e.length - 1][r] = i, !0;
    }
  });
  return t;
}
function Lt(e) {
  let t = (r) => typeof r == "object" && !Array.isArray(r) && r !== null, n = (r, i = "") => {
    Object.entries(Object.getOwnPropertyDescriptors(r)).forEach(([o, { value: s, enumerable: c }]) => {
      if (c === !1 || s === void 0)
        return;
      let a = i === "" ? o : `${i}.${o}`;
      typeof s == "object" && s !== null && s._x_interceptor ? r[o] = s.initialize(e, a, o) : t(s) && s !== r && !(s instanceof Element) && n(s, a);
    });
  };
  return n(e);
}
function Ft(e, t = () => {
}) {
  let n = {
    initialValue: void 0,
    _x_interceptor: !0,
    initialize(r, i, o) {
      return e(this.initialValue, () => vr(r, i), (s) => Le(r, i, s), i, o);
    }
  };
  return t(n), (r) => {
    if (typeof r == "object" && r !== null && r._x_interceptor) {
      let i = n.initialize.bind(n);
      n.initialize = (o, s, c) => {
        let a = r.initialize(o, s, c);
        return n.initialValue = a, i(o, s, c);
      };
    } else
      n.initialValue = r;
    return n;
  };
}
function vr(e, t) {
  return t.split(".").reduce((n, r) => n[r], e);
}
function Le(e, t, n) {
  if (typeof t == "string" && (t = t.split(".")), t.length === 1)
    e[t[0]] = n;
  else {
    if (t.length === 0)
      throw error;
    return e[t[0]] || (e[t[0]] = {}), Le(e[t[0]], t.slice(1), n);
  }
}
var Dt = {};
function E(e, t) {
  Dt[e] = t;
}
function Fe(e, t) {
  return Object.entries(Dt).forEach(([n, r]) => {
    let i = null;
    function o() {
      if (i)
        return i;
      {
        let [s, c] = qt(t);
        return i = { interceptor: Ft, ...s }, It(t, c), i;
      }
    }
    Object.defineProperty(e, `$${n}`, {
      get() {
        return r(t, o());
      },
      enumerable: !1
    });
  }), e;
}
function xr(e, t, n, ...r) {
  try {
    return n(...r);
  } catch (i) {
    ee(i, e, t);
  }
}
function ee(e, t, n = void 0) {
  Object.assign(e, { el: t, expression: n }), console.warn(`Alpine Expression Error: ${e.message}

${n ? 'Expression: "' + n + `"

` : ""}`, t), setTimeout(() => {
    throw e;
  }, 0);
}
var fe = !0;
function Bt(e) {
  let t = fe;
  fe = !1;
  let n = e();
  return fe = t, n;
}
function N(e, t, n = {}) {
  let r;
  return w(e, t)((i) => r = i, n), r;
}
function w(...e) {
  return Kt(...e);
}
var Kt = Wt;
function wr(e) {
  Kt = e;
}
function Wt(e, t) {
  let n = {};
  Fe(n, e);
  let r = [n, ...B(e)], i = typeof t == "function" ? Sr(r, t) : Er(r, t, e);
  return xr.bind(null, e, t, i);
}
function Sr(e, t) {
  return (n = () => {
  }, { scope: r = {}, params: i = [] } = {}) => {
    let o = t.apply(ie([r, ...e]), i);
    pe(n, o);
  };
}
var Te = {};
function Ar(e, t) {
  if (Te[e])
    return Te[e];
  let n = Object.getPrototypeOf(async function() {
  }).constructor, r = /^[\n\s]*if.*\(.*\)/.test(e) || /^(let|const)\s/.test(e) ? `(async()=>{ ${e} })()` : e, o = (() => {
    try {
      return new n(["__self", "scope"], `with (scope) { __self.result = ${r} }; __self.finished = true; return __self.result;`);
    } catch (s) {
      return ee(s, t, e), Promise.resolve();
    }
  })();
  return Te[e] = o, o;
}
function Er(e, t, n) {
  let r = Ar(t, n);
  return (i = () => {
  }, { scope: o = {}, params: s = [] } = {}) => {
    r.result = void 0, r.finished = !1;
    let c = ie([o, ...e]);
    if (typeof r == "function") {
      let a = r(r, c).catch((u) => ee(u, n, t));
      r.finished ? (pe(i, r.result, c, s, n), r.result = void 0) : a.then((u) => {
        pe(i, u, c, s, n);
      }).catch((u) => ee(u, n, t)).finally(() => r.result = void 0);
    }
  };
}
function pe(e, t, n, r, i) {
  if (fe && typeof t == "function") {
    let o = t.apply(n, r);
    o instanceof Promise ? o.then((s) => pe(e, s, n, r)).catch((s) => ee(s, i, t)) : e(o);
  } else
    typeof t == "object" && t instanceof Promise ? t.then((o) => e(o)) : e(t);
}
var rt = "x-";
function H(e = "") {
  return rt + e;
}
function Cr(e) {
  rt = e;
}
var De = {};
function b(e, t) {
  return De[e] = t, {
    before(n) {
      if (!De[n]) {
        console.warn("Cannot find directive `${directive}`. `${name}` will use the default order of execution");
        return;
      }
      const r = j.indexOf(n);
      j.splice(r >= 0 ? r : j.indexOf("DEFAULT"), 0, e);
    }
  };
}
function it(e, t, n) {
  if (t = Array.from(t), e._x_virtualDirectives) {
    let o = Object.entries(e._x_virtualDirectives).map(([c, a]) => ({ name: c, value: a })), s = zt(o);
    o = o.map((c) => s.find((a) => a.name === c.name) ? {
      name: `x-bind:${c.name}`,
      value: `"${c.value}"`
    } : c), t = t.concat(o);
  }
  let r = {};
  return t.map(Gt((o, s) => r[o] = s)).filter(Yt).map(Tr(r, n)).sort(Pr).map((o) => Mr(e, o));
}
function zt(e) {
  return Array.from(e).map(Gt()).filter((t) => !Yt(t));
}
var Be = !1, Y = /* @__PURE__ */ new Map(), Ht = Symbol();
function Or(e) {
  Be = !0;
  let t = Symbol();
  Ht = t, Y.set(t, []);
  let n = () => {
    for (; Y.get(t).length; )
      Y.get(t).shift()();
    Y.delete(t);
  }, r = () => {
    Be = !1, n();
  };
  e(n), r();
}
function qt(e) {
  let t = [], n = (c) => t.push(c), [r, i] = dr(e);
  return t.push(i), [{
    Alpine: se,
    effect: r,
    cleanup: n,
    evaluateLater: w.bind(w, e),
    evaluate: N.bind(N, e)
  }, () => t.forEach((c) => c())];
}
function Mr(e, t) {
  let n = () => {
  }, r = De[t.type] || n, [i, o] = qt(e);
  _r(e, t.original, o);
  let s = () => {
    e._x_ignore || e._x_ignoreSelf || (r.inline && r.inline(e, t, i), r = r.bind(r, e, t, i), Be ? Y.get(Ht).push(r) : r());
  };
  return s.runCleanups = o, s;
}
var Ut = (e, t) => ({ name: n, value: r }) => (n.startsWith(e) && (n = n.replace(e, t)), { name: n, value: r }), Vt = (e) => e;
function Gt(e = () => {
}) {
  return ({ name: t, value: n }) => {
    let { name: r, value: i } = Jt.reduce((o, s) => s(o), { name: t, value: n });
    return r !== t && e(r, t), { name: r, value: i };
  };
}
var Jt = [];
function ot(e) {
  Jt.push(e);
}
function Yt({ name: e }) {
  return Xt().test(e);
}
var Xt = () => new RegExp(`^${rt}([^:^.]+)\\b`);
function Tr(e, t) {
  return ({ name: n, value: r }) => {
    let i = n.match(Xt()), o = n.match(/:([a-zA-Z0-9\-:]+)/), s = n.match(/\.[^.\]]+(?=[^\]]*$)/g) || [], c = t || e[n] || n;
    return {
      type: i ? i[1] : null,
      value: o ? o[1] : null,
      modifiers: s.map((a) => a.replace(".", "")),
      expression: r,
      original: c
    };
  };
}
var Ke = "DEFAULT", j = [
  "ignore",
  "ref",
  "data",
  "id",
  "bind",
  "init",
  "for",
  "model",
  "modelable",
  "transition",
  "show",
  "if",
  Ke,
  "teleport"
];
function Pr(e, t) {
  let n = j.indexOf(e.type) === -1 ? Ke : e.type, r = j.indexOf(t.type) === -1 ? Ke : t.type;
  return j.indexOf(n) - j.indexOf(r);
}
function Q(e, t, n = {}) {
  e.dispatchEvent(new CustomEvent(t, {
    detail: n,
    bubbles: !0,
    composed: !0,
    cancelable: !0
  }));
}
function T(e, t) {
  if (typeof ShadowRoot == "function" && e instanceof ShadowRoot) {
    Array.from(e.children).forEach((i) => T(i, t));
    return;
  }
  let n = !1;
  if (t(e, () => n = !0), n)
    return;
  let r = e.firstElementChild;
  for (; r; )
    T(r, t), r = r.nextElementSibling;
}
function P(e, ...t) {
  console.warn(`Alpine Warning: ${e}`, ...t);
}
var vt = !1;
function $r() {
  vt && P("Alpine has already been initialized on this page. Calling Alpine.start() more than once can cause problems."), vt = !0, document.body || P("Unable to initialize. Trying to load Alpine before `<body>` is available. Did you forget to add `defer` in Alpine's `<script>` tag?"), Q(document, "alpine:init"), Q(document, "alpine:initializing"), et(), pr((t) => $(t, T)), It((t) => on(t)), hr((t, n) => {
    it(t, n).forEach((r) => r());
  });
  let e = (t) => !ge(t.parentElement, !0);
  Array.from(document.querySelectorAll(en())).filter(e).forEach((t) => {
    $(t);
  }), Q(document, "alpine:initialized");
}
var st = [], Qt = [];
function Zt() {
  return st.map((e) => e());
}
function en() {
  return st.concat(Qt).map((e) => e());
}
function tn(e) {
  st.push(e);
}
function nn(e) {
  Qt.push(e);
}
function ge(e, t = !1) {
  return be(e, (n) => {
    if ((t ? en() : Zt()).some((i) => n.matches(i)))
      return !0;
  });
}
function be(e, t) {
  if (e) {
    if (t(e))
      return e;
    if (e._x_teleportBack && (e = e._x_teleportBack), !!e.parentElement)
      return be(e.parentElement, t);
  }
}
function Rr(e) {
  return Zt().some((t) => e.matches(t));
}
var rn = [];
function Ir(e) {
  rn.push(e);
}
function $(e, t = T, n = () => {
}) {
  Or(() => {
    t(e, (r, i) => {
      n(r, i), rn.forEach((o) => o(r, i)), it(r, r.attributes).forEach((o) => o()), r._x_ignore && i();
    });
  });
}
function on(e) {
  T(e, (t) => jt(t));
}
var We = [], ct = !1;
function at(e = () => {
}) {
  return queueMicrotask(() => {
    ct || setTimeout(() => {
      ze();
    });
  }), new Promise((t) => {
    We.push(() => {
      e(), t();
    });
  });
}
function ze() {
  for (ct = !1; We.length; )
    We.shift()();
}
function jr() {
  ct = !0;
}
function ut(e, t) {
  return Array.isArray(t) ? xt(e, t.join(" ")) : typeof t == "object" && t !== null ? kr(e, t) : typeof t == "function" ? ut(e, t()) : xt(e, t);
}
function xt(e, t) {
  let n = (i) => i.split(" ").filter((o) => !e.classList.contains(o)).filter(Boolean), r = (i) => (e.classList.add(...i), () => {
    e.classList.remove(...i);
  });
  return t = t === !0 ? t = "" : t || "", r(n(t));
}
function kr(e, t) {
  let n = (c) => c.split(" ").filter(Boolean), r = Object.entries(t).flatMap(([c, a]) => a ? n(c) : !1).filter(Boolean), i = Object.entries(t).flatMap(([c, a]) => a ? !1 : n(c)).filter(Boolean), o = [], s = [];
  return i.forEach((c) => {
    e.classList.contains(c) && (e.classList.remove(c), s.push(c));
  }), r.forEach((c) => {
    e.classList.contains(c) || (e.classList.add(c), o.push(c));
  }), () => {
    s.forEach((c) => e.classList.add(c)), o.forEach((c) => e.classList.remove(c));
  };
}
function me(e, t) {
  return typeof t == "object" && t !== null ? Nr(e, t) : Lr(e, t);
}
function Nr(e, t) {
  let n = {};
  return Object.entries(t).forEach(([r, i]) => {
    n[r] = e.style[r], r.startsWith("--") || (r = Fr(r)), e.style.setProperty(r, i);
  }), setTimeout(() => {
    e.style.length === 0 && e.removeAttribute("style");
  }), () => {
    me(e, n);
  };
}
function Lr(e, t) {
  let n = e.getAttribute("style", t);
  return e.setAttribute("style", t), () => {
    e.setAttribute("style", n || "");
  };
}
function Fr(e) {
  return e.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase();
}
function He(e, t = () => {
}) {
  let n = !1;
  return function() {
    n ? t.apply(this, arguments) : (n = !0, e.apply(this, arguments));
  };
}
b("transition", (e, { value: t, modifiers: n, expression: r }, { evaluate: i }) => {
  typeof r == "function" && (r = i(r)), r !== !1 && (!r || typeof r == "boolean" ? Br(e, n, t) : Dr(e, r, t));
});
function Dr(e, t, n) {
  sn(e, ut, ""), {
    enter: (i) => {
      e._x_transition.enter.during = i;
    },
    "enter-start": (i) => {
      e._x_transition.enter.start = i;
    },
    "enter-end": (i) => {
      e._x_transition.enter.end = i;
    },
    leave: (i) => {
      e._x_transition.leave.during = i;
    },
    "leave-start": (i) => {
      e._x_transition.leave.start = i;
    },
    "leave-end": (i) => {
      e._x_transition.leave.end = i;
    }
  }[n](t);
}
function Br(e, t, n) {
  sn(e, me);
  let r = !t.includes("in") && !t.includes("out") && !n, i = r || t.includes("in") || ["enter"].includes(n), o = r || t.includes("out") || ["leave"].includes(n);
  t.includes("in") && !r && (t = t.filter((h, m) => m < t.indexOf("out"))), t.includes("out") && !r && (t = t.filter((h, m) => m > t.indexOf("out")));
  let s = !t.includes("opacity") && !t.includes("scale"), c = s || t.includes("opacity"), a = s || t.includes("scale"), u = c ? 0 : 1, l = a ? V(t, "scale", 95) / 100 : 1, p = V(t, "delay", 0) / 1e3, d = V(t, "origin", "center"), y = "opacity, transform", O = V(t, "duration", 150) / 1e3, ce = V(t, "duration", 75) / 1e3, f = "cubic-bezier(0.4, 0.0, 0.2, 1)";
  i && (e._x_transition.enter.during = {
    transformOrigin: d,
    transitionDelay: `${p}s`,
    transitionProperty: y,
    transitionDuration: `${O}s`,
    transitionTimingFunction: f
  }, e._x_transition.enter.start = {
    opacity: u,
    transform: `scale(${l})`
  }, e._x_transition.enter.end = {
    opacity: 1,
    transform: "scale(1)"
  }), o && (e._x_transition.leave.during = {
    transformOrigin: d,
    transitionDelay: `${p}s`,
    transitionProperty: y,
    transitionDuration: `${ce}s`,
    transitionTimingFunction: f
  }, e._x_transition.leave.start = {
    opacity: 1,
    transform: "scale(1)"
  }, e._x_transition.leave.end = {
    opacity: u,
    transform: `scale(${l})`
  });
}
function sn(e, t, n = {}) {
  e._x_transition || (e._x_transition = {
    enter: { during: n, start: n, end: n },
    leave: { during: n, start: n, end: n },
    in(r = () => {
    }, i = () => {
    }) {
      qe(e, t, {
        during: this.enter.during,
        start: this.enter.start,
        end: this.enter.end
      }, r, i);
    },
    out(r = () => {
    }, i = () => {
    }) {
      qe(e, t, {
        during: this.leave.during,
        start: this.leave.start,
        end: this.leave.end
      }, r, i);
    }
  });
}
window.Element.prototype._x_toggleAndCascadeWithTransitions = function(e, t, n, r) {
  const i = document.visibilityState === "visible" ? requestAnimationFrame : setTimeout;
  let o = () => i(n);
  if (t) {
    e._x_transition && (e._x_transition.enter || e._x_transition.leave) ? e._x_transition.enter && (Object.entries(e._x_transition.enter.during).length || Object.entries(e._x_transition.enter.start).length || Object.entries(e._x_transition.enter.end).length) ? e._x_transition.in(n) : o() : e._x_transition ? e._x_transition.in(n) : o();
    return;
  }
  e._x_hidePromise = e._x_transition ? new Promise((s, c) => {
    e._x_transition.out(() => {
    }, () => s(r)), e._x_transitioning.beforeCancel(() => c({ isFromCancelledTransition: !0 }));
  }) : Promise.resolve(r), queueMicrotask(() => {
    let s = cn(e);
    s ? (s._x_hideChildren || (s._x_hideChildren = []), s._x_hideChildren.push(e)) : i(() => {
      let c = (a) => {
        let u = Promise.all([
          a._x_hidePromise,
          ...(a._x_hideChildren || []).map(c)
        ]).then(([l]) => l());
        return delete a._x_hidePromise, delete a._x_hideChildren, u;
      };
      c(e).catch((a) => {
        if (!a.isFromCancelledTransition)
          throw a;
      });
    });
  });
};
function cn(e) {
  let t = e.parentNode;
  if (t)
    return t._x_hidePromise ? t : cn(t);
}
function qe(e, t, { during: n, start: r, end: i } = {}, o = () => {
}, s = () => {
}) {
  if (e._x_transitioning && e._x_transitioning.cancel(), Object.keys(n).length === 0 && Object.keys(r).length === 0 && Object.keys(i).length === 0) {
    o(), s();
    return;
  }
  let c, a, u;
  Kr(e, {
    start() {
      c = t(e, r);
    },
    during() {
      a = t(e, n);
    },
    before: o,
    end() {
      c(), u = t(e, i);
    },
    after: s,
    cleanup() {
      a(), u();
    }
  });
}
function Kr(e, t) {
  let n, r, i, o = He(() => {
    v(() => {
      n = !0, r || t.before(), i || (t.end(), ze()), t.after(), e.isConnected && t.cleanup(), delete e._x_transitioning;
    });
  });
  e._x_transitioning = {
    beforeCancels: [],
    beforeCancel(s) {
      this.beforeCancels.push(s);
    },
    cancel: He(function() {
      for (; this.beforeCancels.length; )
        this.beforeCancels.shift()();
      o();
    }),
    finish: o
  }, v(() => {
    t.start(), t.during();
  }), jr(), requestAnimationFrame(() => {
    if (n)
      return;
    let s = Number(getComputedStyle(e).transitionDuration.replace(/,.*/, "").replace("s", "")) * 1e3, c = Number(getComputedStyle(e).transitionDelay.replace(/,.*/, "").replace("s", "")) * 1e3;
    s === 0 && (s = Number(getComputedStyle(e).animationDuration.replace("s", "")) * 1e3), v(() => {
      t.before();
    }), r = !0, requestAnimationFrame(() => {
      n || (v(() => {
        t.end();
      }), ze(), setTimeout(e._x_transitioning.finish, s + c), i = !0);
    });
  });
}
function V(e, t, n) {
  if (e.indexOf(t) === -1)
    return n;
  const r = e[e.indexOf(t) + 1];
  if (!r || t === "scale" && isNaN(r))
    return n;
  if (t === "duration" || t === "delay") {
    let i = r.match(/([0-9]+)ms/);
    if (i)
      return i[1];
  }
  return t === "origin" && ["top", "right", "left", "center", "bottom"].includes(e[e.indexOf(t) + 2]) ? [r, e[e.indexOf(t) + 2]].join(" ") : r;
}
var te = !1;
function oe(e, t = () => {
}) {
  return (...n) => te ? t(...n) : e(...n);
}
function Wr(e) {
  return (...t) => te && e(...t);
}
function zr(e, t) {
  t._x_dataStack || (t._x_dataStack = e._x_dataStack), te = !0, qr(() => {
    Hr(t);
  }), te = !1;
}
function Hr(e) {
  let t = !1;
  $(e, (r, i) => {
    T(r, (o, s) => {
      if (t && Rr(o))
        return s();
      t = !0, i(o, s);
    });
  });
}
function qr(e) {
  let t = z;
  yt((n, r) => {
    let i = t(n);
    return ne(i), () => {
    };
  }), e(), yt(t);
}
function an(e, t, n, r = []) {
  switch (e._x_bindings || (e._x_bindings = W({})), e._x_bindings[t] = n, t = r.includes("camel") ? Zr(t) : t, t) {
    case "value":
      Ur(e, n);
      break;
    case "style":
      Gr(e, n);
      break;
    case "class":
      Vr(e, n);
      break;
    case "selected":
    case "checked":
      Jr(e, t, n);
      break;
    default:
      un(e, t, n);
      break;
  }
}
function Ur(e, t) {
  if (e.type === "radio")
    e.attributes.value === void 0 && (e.value = t), window.fromModel && (e.checked = wt(e.value, t));
  else if (e.type === "checkbox")
    Number.isInteger(t) ? e.value = t : !Number.isInteger(t) && !Array.isArray(t) && typeof t != "boolean" && ![null, void 0].includes(t) ? e.value = String(t) : Array.isArray(t) ? e.checked = t.some((n) => wt(n, e.value)) : e.checked = !!t;
  else if (e.tagName === "SELECT")
    Qr(e, t);
  else {
    if (e.value === t)
      return;
    e.value = t;
  }
}
function Vr(e, t) {
  e._x_undoAddedClasses && e._x_undoAddedClasses(), e._x_undoAddedClasses = ut(e, t);
}
function Gr(e, t) {
  e._x_undoAddedStyles && e._x_undoAddedStyles(), e._x_undoAddedStyles = me(e, t);
}
function Jr(e, t, n) {
  un(e, t, n), Xr(e, t, n);
}
function un(e, t, n) {
  [null, void 0, !1].includes(n) && ei(t) ? e.removeAttribute(t) : (ln(t) && (n = t), Yr(e, t, n));
}
function Yr(e, t, n) {
  e.getAttribute(t) != n && e.setAttribute(t, n);
}
function Xr(e, t, n) {
  e[t] !== n && (e[t] = n);
}
function Qr(e, t) {
  const n = [].concat(t).map((r) => r + "");
  Array.from(e.options).forEach((r) => {
    r.selected = n.includes(r.value);
  });
}
function Zr(e) {
  return e.toLowerCase().replace(/-(\w)/g, (t, n) => n.toUpperCase());
}
function wt(e, t) {
  return e == t;
}
function ln(e) {
  return [
    "disabled",
    "checked",
    "required",
    "readonly",
    "hidden",
    "open",
    "selected",
    "autofocus",
    "itemscope",
    "multiple",
    "novalidate",
    "allowfullscreen",
    "allowpaymentrequest",
    "formnovalidate",
    "autoplay",
    "controls",
    "loop",
    "muted",
    "playsinline",
    "default",
    "ismap",
    "reversed",
    "async",
    "defer",
    "nomodule"
  ].includes(e);
}
function ei(e) {
  return !["aria-pressed", "aria-checked", "aria-expanded", "aria-selected"].includes(e);
}
function ti(e, t, n) {
  return e._x_bindings && e._x_bindings[t] !== void 0 ? e._x_bindings[t] : fn(e, t, n);
}
function ni(e, t, n, r = !0) {
  if (e._x_bindings && e._x_bindings[t] !== void 0)
    return e._x_bindings[t];
  if (e._x_inlineBindings && e._x_inlineBindings[t] !== void 0) {
    let i = e._x_inlineBindings[t];
    return i.extract = r, Bt(() => N(e, i.expression));
  }
  return fn(e, t, n);
}
function fn(e, t, n) {
  let r = e.getAttribute(t);
  return r === null ? typeof n == "function" ? n() : n : r === "" ? !0 : ln(t) ? !![t, "true"].includes(r) : r;
}
function dn(e, t) {
  var n;
  return function() {
    var r = this, i = arguments, o = function() {
      n = null, e.apply(r, i);
    };
    clearTimeout(n), n = setTimeout(o, t);
  };
}
function pn(e, t) {
  let n;
  return function() {
    let r = this, i = arguments;
    n || (e.apply(r, i), n = !0, setTimeout(() => n = !1, t));
  };
}
function ri(e) {
  (Array.isArray(e) ? e : [e]).forEach((n) => n(se));
}
var I = {}, St = !1;
function ii(e, t) {
  if (St || (I = W(I), St = !0), t === void 0)
    return I[e];
  I[e] = t, typeof t == "object" && t !== null && t.hasOwnProperty("init") && typeof t.init == "function" && I[e].init(), Lt(I[e]);
}
function oi() {
  return I;
}
var hn = {};
function si(e, t) {
  let n = typeof t != "function" ? () => t : t;
  e instanceof Element ? _n(e, n()) : hn[e] = n;
}
function ci(e) {
  return Object.entries(hn).forEach(([t, n]) => {
    Object.defineProperty(e, t, {
      get() {
        return (...r) => n(...r);
      }
    });
  }), e;
}
function _n(e, t, n) {
  let r = [];
  for (; r.length; )
    r.pop()();
  let i = Object.entries(t).map(([s, c]) => ({ name: s, value: c })), o = zt(i);
  i = i.map((s) => o.find((c) => c.name === s.name) ? {
    name: `x-bind:${s.name}`,
    value: `"${s.value}"`
  } : s), it(e, i, n).map((s) => {
    r.push(s.runCleanups), s();
  });
}
var gn = {};
function ai(e, t) {
  gn[e] = t;
}
function ui(e, t) {
  return Object.entries(gn).forEach(([n, r]) => {
    Object.defineProperty(e, n, {
      get() {
        return (...i) => r.bind(t)(...i);
      },
      enumerable: !1
    });
  }), e;
}
var li = {
  get reactive() {
    return W;
  },
  get release() {
    return ne;
  },
  get effect() {
    return z;
  },
  get raw() {
    return Tt;
  },
  version: "3.12.3",
  flushAndStopDeferringMutations: yr,
  dontAutoEvaluateFunctions: Bt,
  disableEffectScheduling: lr,
  startObservingMutations: et,
  stopObservingMutations: kt,
  setReactivityEngine: fr,
  closestDataStack: B,
  skipDuringClone: oe,
  onlyDuringClone: Wr,
  addRootSelector: tn,
  addInitSelector: nn,
  addScopeToNode: re,
  deferMutations: mr,
  mapAttributes: ot,
  evaluateLater: w,
  interceptInit: Ir,
  setEvaluator: wr,
  mergeProxies: ie,
  extractProp: ni,
  findClosest: be,
  closestRoot: ge,
  destroyTree: on,
  interceptor: Ft,
  transition: qe,
  setStyles: me,
  mutateDom: v,
  directive: b,
  throttle: pn,
  debounce: dn,
  evaluate: N,
  initTree: $,
  nextTick: at,
  prefixed: H,
  prefix: Cr,
  plugin: ri,
  magic: E,
  store: ii,
  start: $r,
  clone: zr,
  bound: ti,
  $data: Nt,
  walk: T,
  data: ai,
  bind: si
}, se = li;
function fi(e, t) {
  const n = /* @__PURE__ */ Object.create(null), r = e.split(",");
  for (let i = 0; i < r.length; i++)
    n[r[i]] = !0;
  return t ? (i) => !!n[i.toLowerCase()] : (i) => !!n[i];
}
var di = Object.freeze({}), bn = Object.assign, pi = Object.prototype.hasOwnProperty, ye = (e, t) => pi.call(e, t), L = Array.isArray, Z = (e) => mn(e) === "[object Map]", hi = (e) => typeof e == "string", lt = (e) => typeof e == "symbol", ve = (e) => e !== null && typeof e == "object", _i = Object.prototype.toString, mn = (e) => _i.call(e), yn = (e) => mn(e).slice(8, -1), ft = (e) => hi(e) && e !== "NaN" && e[0] !== "-" && "" + parseInt(e, 10) === e, gi = (e) => {
  const t = /* @__PURE__ */ Object.create(null);
  return (n) => t[n] || (t[n] = e(n));
}, bi = gi((e) => e.charAt(0).toUpperCase() + e.slice(1)), vn = (e, t) => e !== t && (e === e || t === t), Ue = /* @__PURE__ */ new WeakMap(), G = [], C, F = Symbol("iterate"), Ve = Symbol("Map key iterate");
function mi(e) {
  return e && e._isEffect === !0;
}
function yi(e, t = di) {
  mi(e) && (e = e.raw);
  const n = wi(e, t);
  return t.lazy || n(), n;
}
function vi(e) {
  e.active && (xn(e), e.options.onStop && e.options.onStop(), e.active = !1);
}
var xi = 0;
function wi(e, t) {
  const n = function() {
    if (!n.active)
      return e();
    if (!G.includes(n)) {
      xn(n);
      try {
        return Ai(), G.push(n), C = n, e();
      } finally {
        G.pop(), wn(), C = G[G.length - 1];
      }
    }
  };
  return n.id = xi++, n.allowRecurse = !!t.allowRecurse, n._isEffect = !0, n.active = !0, n.raw = e, n.deps = [], n.options = t, n;
}
function xn(e) {
  const { deps: t } = e;
  if (t.length) {
    for (let n = 0; n < t.length; n++)
      t[n].delete(e);
    t.length = 0;
  }
}
var K = !0, dt = [];
function Si() {
  dt.push(K), K = !1;
}
function Ai() {
  dt.push(K), K = !0;
}
function wn() {
  const e = dt.pop();
  K = e === void 0 ? !0 : e;
}
function A(e, t, n) {
  if (!K || C === void 0)
    return;
  let r = Ue.get(e);
  r || Ue.set(e, r = /* @__PURE__ */ new Map());
  let i = r.get(n);
  i || r.set(n, i = /* @__PURE__ */ new Set()), i.has(C) || (i.add(C), C.deps.push(i), C.options.onTrack && C.options.onTrack({
    effect: C,
    target: e,
    type: t,
    key: n
  }));
}
function R(e, t, n, r, i, o) {
  const s = Ue.get(e);
  if (!s)
    return;
  const c = /* @__PURE__ */ new Set(), a = (l) => {
    l && l.forEach((p) => {
      (p !== C || p.allowRecurse) && c.add(p);
    });
  };
  if (t === "clear")
    s.forEach(a);
  else if (n === "length" && L(e))
    s.forEach((l, p) => {
      (p === "length" || p >= r) && a(l);
    });
  else
    switch (n !== void 0 && a(s.get(n)), t) {
      case "add":
        L(e) ? ft(n) && a(s.get("length")) : (a(s.get(F)), Z(e) && a(s.get(Ve)));
        break;
      case "delete":
        L(e) || (a(s.get(F)), Z(e) && a(s.get(Ve)));
        break;
      case "set":
        Z(e) && a(s.get(F));
        break;
    }
  const u = (l) => {
    l.options.onTrigger && l.options.onTrigger({
      effect: l,
      target: e,
      key: n,
      type: t,
      newValue: r,
      oldValue: i,
      oldTarget: o
    }), l.options.scheduler ? l.options.scheduler(l) : l();
  };
  c.forEach(u);
}
var Ei = /* @__PURE__ */ fi("__proto__,__v_isRef,__isVue"), Sn = new Set(Object.getOwnPropertyNames(Symbol).map((e) => Symbol[e]).filter(lt)), Ci = /* @__PURE__ */ xe(), Oi = /* @__PURE__ */ xe(!1, !0), Mi = /* @__PURE__ */ xe(!0), Ti = /* @__PURE__ */ xe(!0, !0), he = {};
["includes", "indexOf", "lastIndexOf"].forEach((e) => {
  const t = Array.prototype[e];
  he[e] = function(...n) {
    const r = _(this);
    for (let o = 0, s = this.length; o < s; o++)
      A(r, "get", o + "");
    const i = t.apply(r, n);
    return i === -1 || i === !1 ? t.apply(r, n.map(_)) : i;
  };
});
["push", "pop", "shift", "unshift", "splice"].forEach((e) => {
  const t = Array.prototype[e];
  he[e] = function(...n) {
    Si();
    const r = t.apply(this, n);
    return wn(), r;
  };
});
function xe(e = !1, t = !1) {
  return function(r, i, o) {
    if (i === "__v_isReactive")
      return !e;
    if (i === "__v_isReadonly")
      return e;
    if (i === "__v_raw" && o === (e ? t ? Di : Fn : t ? Fi : Ln).get(r))
      return r;
    const s = L(r);
    if (!e && s && ye(he, i))
      return Reflect.get(he, i, o);
    const c = Reflect.get(r, i, o);
    return (lt(i) ? Sn.has(i) : Ei(i)) || (e || A(r, "get", i), t) ? c : Ge(c) ? !s || !ft(i) ? c.value : c : ve(c) ? e ? Dn(c) : gt(c) : c;
  };
}
var Pi = /* @__PURE__ */ An(), $i = /* @__PURE__ */ An(!0);
function An(e = !1) {
  return function(n, r, i, o) {
    let s = n[r];
    if (!e && (i = _(i), s = _(s), !L(n) && Ge(s) && !Ge(i)))
      return s.value = i, !0;
    const c = L(n) && ft(r) ? Number(r) < n.length : ye(n, r), a = Reflect.set(n, r, i, o);
    return n === _(o) && (c ? vn(i, s) && R(n, "set", r, i, s) : R(n, "add", r, i)), a;
  };
}
function Ri(e, t) {
  const n = ye(e, t), r = e[t], i = Reflect.deleteProperty(e, t);
  return i && n && R(e, "delete", t, void 0, r), i;
}
function Ii(e, t) {
  const n = Reflect.has(e, t);
  return (!lt(t) || !Sn.has(t)) && A(e, "has", t), n;
}
function ji(e) {
  return A(e, "iterate", L(e) ? "length" : F), Reflect.ownKeys(e);
}
var En = {
  get: Ci,
  set: Pi,
  deleteProperty: Ri,
  has: Ii,
  ownKeys: ji
}, Cn = {
  get: Mi,
  set(e, t) {
    return console.warn(`Set operation on key "${String(t)}" failed: target is readonly.`, e), !0;
  },
  deleteProperty(e, t) {
    return console.warn(`Delete operation on key "${String(t)}" failed: target is readonly.`, e), !0;
  }
};
bn({}, En, {
  get: Oi,
  set: $i
});
bn({}, Cn, {
  get: Ti
});
var pt = (e) => ve(e) ? gt(e) : e, ht = (e) => ve(e) ? Dn(e) : e, _t = (e) => e, we = (e) => Reflect.getPrototypeOf(e);
function Se(e, t, n = !1, r = !1) {
  e = e.__v_raw;
  const i = _(e), o = _(t);
  t !== o && !n && A(i, "get", t), !n && A(i, "get", o);
  const { has: s } = we(i), c = r ? _t : n ? ht : pt;
  if (s.call(i, t))
    return c(e.get(t));
  if (s.call(i, o))
    return c(e.get(o));
  e !== i && e.get(t);
}
function Ae(e, t = !1) {
  const n = this.__v_raw, r = _(n), i = _(e);
  return e !== i && !t && A(r, "has", e), !t && A(r, "has", i), e === i ? n.has(e) : n.has(e) || n.has(i);
}
function Ee(e, t = !1) {
  return e = e.__v_raw, !t && A(_(e), "iterate", F), Reflect.get(e, "size", e);
}
function On(e) {
  e = _(e);
  const t = _(this);
  return we(t).has.call(t, e) || (t.add(e), R(t, "add", e, e)), this;
}
function Mn(e, t) {
  t = _(t);
  const n = _(this), { has: r, get: i } = we(n);
  let o = r.call(n, e);
  o ? Nn(n, r, e) : (e = _(e), o = r.call(n, e));
  const s = i.call(n, e);
  return n.set(e, t), o ? vn(t, s) && R(n, "set", e, t, s) : R(n, "add", e, t), this;
}
function Tn(e) {
  const t = _(this), { has: n, get: r } = we(t);
  let i = n.call(t, e);
  i ? Nn(t, n, e) : (e = _(e), i = n.call(t, e));
  const o = r ? r.call(t, e) : void 0, s = t.delete(e);
  return i && R(t, "delete", e, void 0, o), s;
}
function Pn() {
  const e = _(this), t = e.size !== 0, n = Z(e) ? new Map(e) : new Set(e), r = e.clear();
  return t && R(e, "clear", void 0, void 0, n), r;
}
function Ce(e, t) {
  return function(r, i) {
    const o = this, s = o.__v_raw, c = _(s), a = t ? _t : e ? ht : pt;
    return !e && A(c, "iterate", F), s.forEach((u, l) => r.call(i, a(u), a(l), o));
  };
}
function ue(e, t, n) {
  return function(...r) {
    const i = this.__v_raw, o = _(i), s = Z(o), c = e === "entries" || e === Symbol.iterator && s, a = e === "keys" && s, u = i[e](...r), l = n ? _t : t ? ht : pt;
    return !t && A(o, "iterate", a ? Ve : F), {
      next() {
        const { value: p, done: d } = u.next();
        return d ? { value: p, done: d } : {
          value: c ? [l(p[0]), l(p[1])] : l(p),
          done: d
        };
      },
      [Symbol.iterator]() {
        return this;
      }
    };
  };
}
function M(e) {
  return function(...t) {
    {
      const n = t[0] ? `on key "${t[0]}" ` : "";
      console.warn(`${bi(e)} operation ${n}failed: target is readonly.`, _(this));
    }
    return e === "delete" ? !1 : this;
  };
}
var $n = {
  get(e) {
    return Se(this, e);
  },
  get size() {
    return Ee(this);
  },
  has: Ae,
  add: On,
  set: Mn,
  delete: Tn,
  clear: Pn,
  forEach: Ce(!1, !1)
}, Rn = {
  get(e) {
    return Se(this, e, !1, !0);
  },
  get size() {
    return Ee(this);
  },
  has: Ae,
  add: On,
  set: Mn,
  delete: Tn,
  clear: Pn,
  forEach: Ce(!1, !0)
}, In = {
  get(e) {
    return Se(this, e, !0);
  },
  get size() {
    return Ee(this, !0);
  },
  has(e) {
    return Ae.call(this, e, !0);
  },
  add: M("add"),
  set: M("set"),
  delete: M("delete"),
  clear: M("clear"),
  forEach: Ce(!0, !1)
}, jn = {
  get(e) {
    return Se(this, e, !0, !0);
  },
  get size() {
    return Ee(this, !0);
  },
  has(e) {
    return Ae.call(this, e, !0);
  },
  add: M("add"),
  set: M("set"),
  delete: M("delete"),
  clear: M("clear"),
  forEach: Ce(!0, !0)
}, ki = ["keys", "values", "entries", Symbol.iterator];
ki.forEach((e) => {
  $n[e] = ue(e, !1, !1), In[e] = ue(e, !0, !1), Rn[e] = ue(e, !1, !0), jn[e] = ue(e, !0, !0);
});
function kn(e, t) {
  const n = t ? e ? jn : Rn : e ? In : $n;
  return (r, i, o) => i === "__v_isReactive" ? !e : i === "__v_isReadonly" ? e : i === "__v_raw" ? r : Reflect.get(ye(n, i) && i in r ? n : r, i, o);
}
var Ni = {
  get: kn(!1, !1)
}, Li = {
  get: kn(!0, !1)
};
function Nn(e, t, n) {
  const r = _(n);
  if (r !== n && t.call(e, r)) {
    const i = yn(e);
    console.warn(`Reactive ${i} contains both the raw and reactive versions of the same object${i === "Map" ? " as keys" : ""}, which can lead to inconsistencies. Avoid differentiating between the raw and reactive versions of an object and only use the reactive version if possible.`);
  }
}
var Ln = /* @__PURE__ */ new WeakMap(), Fi = /* @__PURE__ */ new WeakMap(), Fn = /* @__PURE__ */ new WeakMap(), Di = /* @__PURE__ */ new WeakMap();
function Bi(e) {
  switch (e) {
    case "Object":
    case "Array":
      return 1;
    case "Map":
    case "Set":
    case "WeakMap":
    case "WeakSet":
      return 2;
    default:
      return 0;
  }
}
function Ki(e) {
  return e.__v_skip || !Object.isExtensible(e) ? 0 : Bi(yn(e));
}
function gt(e) {
  return e && e.__v_isReadonly ? e : Bn(e, !1, En, Ni, Ln);
}
function Dn(e) {
  return Bn(e, !0, Cn, Li, Fn);
}
function Bn(e, t, n, r, i) {
  if (!ve(e))
    return console.warn(`value cannot be made reactive: ${String(e)}`), e;
  if (e.__v_raw && !(t && e.__v_isReactive))
    return e;
  const o = i.get(e);
  if (o)
    return o;
  const s = Ki(e);
  if (s === 0)
    return e;
  const c = new Proxy(e, s === 2 ? r : n);
  return i.set(e, c), c;
}
function _(e) {
  return e && _(e.__v_raw) || e;
}
function Ge(e) {
  return !!(e && e.__v_isRef === !0);
}
E("nextTick", () => at);
E("dispatch", (e) => Q.bind(Q, e));
E("watch", (e, { evaluateLater: t, effect: n }) => (r, i) => {
  let o = t(r), s = !0, c, a = n(() => o((u) => {
    JSON.stringify(u), s ? c = u : queueMicrotask(() => {
      i(u, c), c = u;
    }), s = !1;
  }));
  e._x_effects.delete(a);
});
E("store", oi);
E("data", (e) => Nt(e));
E("root", (e) => ge(e));
E("refs", (e) => (e._x_refs_proxy || (e._x_refs_proxy = ie(Wi(e))), e._x_refs_proxy));
function Wi(e) {
  let t = [], n = e;
  for (; n; )
    n._x_refs && t.push(n._x_refs), n = n.parentNode;
  return t;
}
var Pe = {};
function Kn(e) {
  return Pe[e] || (Pe[e] = 0), ++Pe[e];
}
function zi(e, t) {
  return be(e, (n) => {
    if (n._x_ids && n._x_ids[t])
      return !0;
  });
}
function Hi(e, t) {
  e._x_ids || (e._x_ids = {}), e._x_ids[t] || (e._x_ids[t] = Kn(t));
}
E("id", (e) => (t, n = null) => {
  let r = zi(e, t), i = r ? r._x_ids[t] : Kn(t);
  return n ? `${t}-${i}-${n}` : `${t}-${i}`;
});
E("el", (e) => e);
Wn("Focus", "focus", "focus");
Wn("Persist", "persist", "persist");
function Wn(e, t, n) {
  E(t, (r) => P(`You can't use [$${directiveName}] without first installing the "${e}" plugin here: https://alpinejs.dev/plugins/${n}`, r));
}
function qi({ get: e, set: t }, { get: n, set: r }) {
  let i = !0, o, s, c = z(() => {
    let a, u;
    i ? (a = e(), r(a), u = n(), i = !1) : (a = e(), u = n(), s = JSON.stringify(a), JSON.stringify(u), s !== o ? (u = n(), r(a), u = a) : (t(u), a = u)), o = JSON.stringify(a), JSON.stringify(u);
  });
  return () => {
    ne(c);
  };
}
b("modelable", (e, { expression: t }, { effect: n, evaluateLater: r, cleanup: i }) => {
  let o = r(t), s = () => {
    let l;
    return o((p) => l = p), l;
  }, c = r(`${t} = __placeholder`), a = (l) => c(() => {
  }, { scope: { __placeholder: l } }), u = s();
  a(u), queueMicrotask(() => {
    if (!e._x_model)
      return;
    e._x_removeModelListeners.default();
    let l = e._x_model.get, p = e._x_model.set, d = qi({
      get() {
        return l();
      },
      set(y) {
        p(y);
      }
    }, {
      get() {
        return s();
      },
      set(y) {
        a(y);
      }
    });
    i(d);
  });
});
var Ui = document.createElement("div");
b("teleport", (e, { modifiers: t, expression: n }, { cleanup: r }) => {
  e.tagName.toLowerCase() !== "template" && P("x-teleport can only be used on a <template> tag", e);
  let i = oe(() => document.querySelector(n), () => Ui)();
  i || P(`Cannot find x-teleport element for selector: "${n}"`);
  let o = e.content.cloneNode(!0).firstElementChild;
  e._x_teleport = o, o._x_teleportBack = e, e._x_forwardEvents && e._x_forwardEvents.forEach((s) => {
    o.addEventListener(s, (c) => {
      c.stopPropagation(), e.dispatchEvent(new c.constructor(c.type, c));
    });
  }), re(o, {}, e), v(() => {
    t.includes("prepend") ? i.parentNode.insertBefore(o, i) : t.includes("append") ? i.parentNode.insertBefore(o, i.nextSibling) : i.appendChild(o), $(o), o._x_ignore = !0;
  }), r(() => o.remove());
});
var zn = () => {
};
zn.inline = (e, { modifiers: t }, { cleanup: n }) => {
  t.includes("self") ? e._x_ignoreSelf = !0 : e._x_ignore = !0, n(() => {
    t.includes("self") ? delete e._x_ignoreSelf : delete e._x_ignore;
  });
};
b("ignore", zn);
b("effect", (e, { expression: t }, { effect: n }) => n(w(e, t)));
function Je(e, t, n, r) {
  let i = e, o = (a) => r(a), s = {}, c = (a, u) => (l) => u(a, l);
  if (n.includes("dot") && (t = Vi(t)), n.includes("camel") && (t = Gi(t)), n.includes("passive") && (s.passive = !0), n.includes("capture") && (s.capture = !0), n.includes("window") && (i = window), n.includes("document") && (i = document), n.includes("debounce")) {
    let a = n[n.indexOf("debounce") + 1] || "invalid-wait", u = _e(a.split("ms")[0]) ? Number(a.split("ms")[0]) : 250;
    o = dn(o, u);
  }
  if (n.includes("throttle")) {
    let a = n[n.indexOf("throttle") + 1] || "invalid-wait", u = _e(a.split("ms")[0]) ? Number(a.split("ms")[0]) : 250;
    o = pn(o, u);
  }
  return n.includes("prevent") && (o = c(o, (a, u) => {
    u.preventDefault(), a(u);
  })), n.includes("stop") && (o = c(o, (a, u) => {
    u.stopPropagation(), a(u);
  })), n.includes("self") && (o = c(o, (a, u) => {
    u.target === e && a(u);
  })), (n.includes("away") || n.includes("outside")) && (i = document, o = c(o, (a, u) => {
    e.contains(u.target) || u.target.isConnected !== !1 && (e.offsetWidth < 1 && e.offsetHeight < 1 || e._x_isShown !== !1 && a(u));
  })), n.includes("once") && (o = c(o, (a, u) => {
    a(u), i.removeEventListener(t, o, s);
  })), o = c(o, (a, u) => {
    Yi(t) && Xi(u, n) || a(u);
  }), i.addEventListener(t, o, s), () => {
    i.removeEventListener(t, o, s);
  };
}
function Vi(e) {
  return e.replace(/-/g, ".");
}
function Gi(e) {
  return e.toLowerCase().replace(/-(\w)/g, (t, n) => n.toUpperCase());
}
function _e(e) {
  return !Array.isArray(e) && !isNaN(e);
}
function Ji(e) {
  return [" ", "_"].includes(e) ? e : e.replace(/([a-z])([A-Z])/g, "$1-$2").replace(/[_\s]/, "-").toLowerCase();
}
function Yi(e) {
  return ["keydown", "keyup"].includes(e);
}
function Xi(e, t) {
  let n = t.filter((o) => !["window", "document", "prevent", "stop", "once", "capture"].includes(o));
  if (n.includes("debounce")) {
    let o = n.indexOf("debounce");
    n.splice(o, _e((n[o + 1] || "invalid-wait").split("ms")[0]) ? 2 : 1);
  }
  if (n.includes("throttle")) {
    let o = n.indexOf("throttle");
    n.splice(o, _e((n[o + 1] || "invalid-wait").split("ms")[0]) ? 2 : 1);
  }
  if (n.length === 0 || n.length === 1 && At(e.key).includes(n[0]))
    return !1;
  const i = ["ctrl", "shift", "alt", "meta", "cmd", "super"].filter((o) => n.includes(o));
  return n = n.filter((o) => !i.includes(o)), !(i.length > 0 && i.filter((s) => ((s === "cmd" || s === "super") && (s = "meta"), e[`${s}Key`])).length === i.length && At(e.key).includes(n[0]));
}
function At(e) {
  if (!e)
    return [];
  e = Ji(e);
  let t = {
    ctrl: "control",
    slash: "/",
    space: " ",
    spacebar: " ",
    cmd: "meta",
    esc: "escape",
    up: "arrow-up",
    down: "arrow-down",
    left: "arrow-left",
    right: "arrow-right",
    period: ".",
    equal: "=",
    minus: "-",
    underscore: "_"
  };
  return t[e] = e, Object.keys(t).map((n) => {
    if (t[n] === e)
      return n;
  }).filter((n) => n);
}
b("model", (e, { modifiers: t, expression: n }, { effect: r, cleanup: i }) => {
  let o = e;
  t.includes("parent") && (o = e.parentNode);
  let s = w(o, n), c;
  typeof n == "string" ? c = w(o, `${n} = __placeholder`) : typeof n == "function" && typeof n() == "string" ? c = w(o, `${n()} = __placeholder`) : c = () => {
  };
  let a = () => {
    let d;
    return s((y) => d = y), Et(d) ? d.get() : d;
  }, u = (d) => {
    let y;
    s((O) => y = O), Et(y) ? y.set(d) : c(() => {
    }, {
      scope: { __placeholder: d }
    });
  };
  typeof n == "string" && e.type === "radio" && v(() => {
    e.hasAttribute("name") || e.setAttribute("name", n);
  });
  var l = e.tagName.toLowerCase() === "select" || ["checkbox", "radio"].includes(e.type) || t.includes("lazy") ? "change" : "input";
  let p = te ? () => {
  } : Je(e, l, t, (d) => {
    u(Qi(e, t, d, a()));
  });
  if (t.includes("fill") && [null, ""].includes(a()) && e.dispatchEvent(new Event(l, {})), e._x_removeModelListeners || (e._x_removeModelListeners = {}), e._x_removeModelListeners.default = p, i(() => e._x_removeModelListeners.default()), e.form) {
    let d = Je(e.form, "reset", [], (y) => {
      at(() => e._x_model && e._x_model.set(e.value));
    });
    i(() => d());
  }
  e._x_model = {
    get() {
      return a();
    },
    set(d) {
      u(d);
    }
  }, e._x_forceModelUpdate = (d) => {
    d = d === void 0 ? a() : d, d === void 0 && typeof n == "string" && n.match(/\./) && (d = ""), window.fromModel = !0, v(() => an(e, "value", d)), delete window.fromModel;
  }, r(() => {
    let d = a();
    t.includes("unintrusive") && document.activeElement.isSameNode(e) || e._x_forceModelUpdate(d);
  });
});
function Qi(e, t, n, r) {
  return v(() => {
    if (n instanceof CustomEvent && n.detail !== void 0)
      return n.detail ?? n.target.value;
    if (e.type === "checkbox")
      if (Array.isArray(r)) {
        let i = t.includes("number") ? $e(n.target.value) : n.target.value;
        return n.target.checked ? r.concat([i]) : r.filter((o) => !Zi(o, i));
      } else
        return n.target.checked;
    else {
      if (e.tagName.toLowerCase() === "select" && e.multiple)
        return t.includes("number") ? Array.from(n.target.selectedOptions).map((i) => {
          let o = i.value || i.text;
          return $e(o);
        }) : Array.from(n.target.selectedOptions).map((i) => i.value || i.text);
      {
        let i = n.target.value;
        return t.includes("number") ? $e(i) : t.includes("trim") ? i.trim() : i;
      }
    }
  });
}
function $e(e) {
  let t = e ? parseFloat(e) : null;
  return eo(t) ? t : e;
}
function Zi(e, t) {
  return e == t;
}
function eo(e) {
  return !Array.isArray(e) && !isNaN(e);
}
function Et(e) {
  return e !== null && typeof e == "object" && typeof e.get == "function" && typeof e.set == "function";
}
b("cloak", (e) => queueMicrotask(() => v(() => e.removeAttribute(H("cloak")))));
nn(() => `[${H("init")}]`);
b("init", oe((e, { expression: t }, { evaluate: n }) => typeof t == "string" ? !!t.trim() && n(t, {}, !1) : n(t, {}, !1)));
b("text", (e, { expression: t }, { effect: n, evaluateLater: r }) => {
  let i = r(t);
  n(() => {
    i((o) => {
      v(() => {
        e.textContent = o;
      });
    });
  });
});
b("html", (e, { expression: t }, { effect: n, evaluateLater: r }) => {
  let i = r(t);
  n(() => {
    i((o) => {
      v(() => {
        e.innerHTML = o, e._x_ignoreSelf = !0, $(e), delete e._x_ignoreSelf;
      });
    });
  });
});
ot(Ut(":", Vt(H("bind:"))));
var Hn = (e, { value: t, modifiers: n, expression: r, original: i }, { effect: o }) => {
  if (!t) {
    let c = {};
    ci(c), w(e, r)((u) => {
      _n(e, u, i);
    }, { scope: c });
    return;
  }
  if (t === "key")
    return to(e, r);
  if (e._x_inlineBindings && e._x_inlineBindings[t] && e._x_inlineBindings[t].extract)
    return;
  let s = w(e, r);
  o(() => s((c) => {
    c === void 0 && typeof r == "string" && r.match(/\./) && (c = ""), v(() => an(e, t, c, n));
  }));
};
Hn.inline = (e, { value: t, modifiers: n, expression: r }) => {
  t && (e._x_inlineBindings || (e._x_inlineBindings = {}), e._x_inlineBindings[t] = { expression: r, extract: !1 });
};
b("bind", Hn);
function to(e, t) {
  e._x_keyExpression = t;
}
tn(() => `[${H("data")}]`);
b("data", oe((e, { expression: t }, { cleanup: n }) => {
  t = t === "" ? "{}" : t;
  let r = {};
  Fe(r, e);
  let i = {};
  ui(i, r);
  let o = N(e, t, { scope: i });
  (o === void 0 || o === !0) && (o = {}), Fe(o, e);
  let s = W(o);
  Lt(s);
  let c = re(e, s);
  s.init && N(e, s.init), n(() => {
    s.destroy && N(e, s.destroy), c();
  });
}));
b("show", (e, { modifiers: t, expression: n }, { effect: r }) => {
  let i = w(e, n);
  e._x_doHide || (e._x_doHide = () => {
    v(() => {
      e.style.setProperty("display", "none", t.includes("important") ? "important" : void 0);
    });
  }), e._x_doShow || (e._x_doShow = () => {
    v(() => {
      e.style.length === 1 && e.style.display === "none" ? e.removeAttribute("style") : e.style.removeProperty("display");
    });
  });
  let o = () => {
    e._x_doHide(), e._x_isShown = !1;
  }, s = () => {
    e._x_doShow(), e._x_isShown = !0;
  }, c = () => setTimeout(s), a = He((p) => p ? s() : o(), (p) => {
    typeof e._x_toggleAndCascadeWithTransitions == "function" ? e._x_toggleAndCascadeWithTransitions(e, p, s, o) : p ? c() : o();
  }), u, l = !0;
  r(() => i((p) => {
    !l && p === u || (t.includes("immediate") && (p ? c() : o()), a(p), u = p, l = !1);
  }));
});
b("for", (e, { expression: t }, { effect: n, cleanup: r }) => {
  let i = ro(t), o = w(e, i.items), s = w(e, e._x_keyExpression || "index");
  e._x_prevKeys = [], e._x_lookup = {}, n(() => no(e, i, o, s)), r(() => {
    Object.values(e._x_lookup).forEach((c) => c.remove()), delete e._x_prevKeys, delete e._x_lookup;
  });
});
function no(e, t, n, r) {
  let i = (s) => typeof s == "object" && !Array.isArray(s), o = e;
  n((s) => {
    io(s) && s >= 0 && (s = Array.from(Array(s).keys(), (f) => f + 1)), s === void 0 && (s = []);
    let c = e._x_lookup, a = e._x_prevKeys, u = [], l = [];
    if (i(s))
      s = Object.entries(s).map(([f, h]) => {
        let m = Ct(t, h, f, s);
        r((x) => l.push(x), { scope: { index: f, ...m } }), u.push(m);
      });
    else
      for (let f = 0; f < s.length; f++) {
        let h = Ct(t, s[f], f, s);
        r((m) => l.push(m), { scope: { index: f, ...h } }), u.push(h);
      }
    let p = [], d = [], y = [], O = [];
    for (let f = 0; f < a.length; f++) {
      let h = a[f];
      l.indexOf(h) === -1 && y.push(h);
    }
    a = a.filter((f) => !y.includes(f));
    let ce = "template";
    for (let f = 0; f < l.length; f++) {
      let h = l[f], m = a.indexOf(h);
      if (m === -1)
        a.splice(f, 0, h), p.push([ce, f]);
      else if (m !== f) {
        let x = a.splice(f, 1)[0], S = a.splice(m - 1, 1)[0];
        a.splice(f, 0, S), a.splice(m, 0, x), d.push([x, S]);
      } else
        O.push(h);
      ce = h;
    }
    for (let f = 0; f < y.length; f++) {
      let h = y[f];
      c[h]._x_effects && c[h]._x_effects.forEach(Mt), c[h].remove(), c[h] = null, delete c[h];
    }
    for (let f = 0; f < d.length; f++) {
      let [h, m] = d[f], x = c[h], S = c[m], D = document.createElement("div");
      v(() => {
        S || P('x-for ":key" is undefined or invalid', o), S.after(D), x.after(S), S._x_currentIfEl && S.after(S._x_currentIfEl), D.before(x), x._x_currentIfEl && x.after(x._x_currentIfEl), D.remove();
      }), S._x_refreshXForScope(u[l.indexOf(m)]);
    }
    for (let f = 0; f < p.length; f++) {
      let [h, m] = p[f], x = h === "template" ? o : c[h];
      x._x_currentIfEl && (x = x._x_currentIfEl);
      let S = u[m], D = l[m], q = document.importNode(o.content, !0).firstElementChild, bt = W(S);
      re(q, bt, o), q._x_refreshXForScope = (Vn) => {
        Object.entries(Vn).forEach(([Gn, Jn]) => {
          bt[Gn] = Jn;
        });
      }, v(() => {
        x.after(q), $(q);
      }), typeof D == "object" && P("x-for key cannot be an object, it must be a string or an integer", o), c[D] = q;
    }
    for (let f = 0; f < O.length; f++)
      c[O[f]]._x_refreshXForScope(u[l.indexOf(O[f])]);
    o._x_prevKeys = l;
  });
}
function ro(e) {
  let t = /,([^,\}\]]*)(?:,([^,\}\]]*))?$/, n = /^\s*\(|\)\s*$/g, r = /([\s\S]*?)\s+(?:in|of)\s+([\s\S]*)/, i = e.match(r);
  if (!i)
    return;
  let o = {};
  o.items = i[2].trim();
  let s = i[1].replace(n, "").trim(), c = s.match(t);
  return c ? (o.item = s.replace(t, "").trim(), o.index = c[1].trim(), c[2] && (o.collection = c[2].trim())) : o.item = s, o;
}
function Ct(e, t, n, r) {
  let i = {};
  return /^\[.*\]$/.test(e.item) && Array.isArray(t) ? e.item.replace("[", "").replace("]", "").split(",").map((s) => s.trim()).forEach((s, c) => {
    i[s] = t[c];
  }) : /^\{.*\}$/.test(e.item) && !Array.isArray(t) && typeof t == "object" ? e.item.replace("{", "").replace("}", "").split(",").map((s) => s.trim()).forEach((s) => {
    i[s] = t[s];
  }) : i[e.item] = t, e.index && (i[e.index] = n), e.collection && (i[e.collection] = r), i;
}
function io(e) {
  return !Array.isArray(e) && !isNaN(e);
}
function qn() {
}
qn.inline = (e, { expression: t }, { cleanup: n }) => {
  let r = ge(e);
  r._x_refs || (r._x_refs = {}), r._x_refs[t] = e, n(() => delete r._x_refs[t]);
};
b("ref", qn);
b("if", (e, { expression: t }, { effect: n, cleanup: r }) => {
  let i = w(e, t), o = () => {
    if (e._x_currentIfEl)
      return e._x_currentIfEl;
    let c = e.content.cloneNode(!0).firstElementChild;
    return re(c, {}, e), v(() => {
      e.after(c), $(c);
    }), e._x_currentIfEl = c, e._x_undoIf = () => {
      T(c, (a) => {
        a._x_effects && a._x_effects.forEach(Mt);
      }), c.remove(), delete e._x_currentIfEl;
    }, c;
  }, s = () => {
    e._x_undoIf && (e._x_undoIf(), delete e._x_undoIf);
  };
  n(() => i((c) => {
    c ? o() : s();
  })), r(() => e._x_undoIf && e._x_undoIf());
});
b("id", (e, { expression: t }, { evaluate: n }) => {
  n(t).forEach((i) => Hi(e, i));
});
ot(Ut("@", Vt(H("on:"))));
b("on", oe((e, { value: t, modifiers: n, expression: r }, { cleanup: i }) => {
  let o = r ? w(e, r) : () => {
  };
  e.tagName.toLowerCase() === "template" && (e._x_forwardEvents || (e._x_forwardEvents = []), e._x_forwardEvents.includes(t) || e._x_forwardEvents.push(t));
  let s = Je(e, t, n, (c) => {
    o(() => {
    }, { scope: { $event: c }, params: [c] });
  });
  i(() => s());
}));
Oe("Collapse", "collapse", "collapse");
Oe("Intersect", "intersect", "intersect");
Oe("Focus", "trap", "focus");
Oe("Mask", "mask", "mask");
function Oe(e, t, n) {
  b(t, (r) => P(`You can't use [x-${t}] without first installing the "${e}" plugin here: https://alpinejs.dev/plugins/${n}`, r));
}
se.setEvaluator(Wt);
se.setReactivityEngine({ reactive: gt, effect: yi, release: vi, raw: _ });
var oo = se, Un = oo;
window.Alpine = Un;
Un.start();
