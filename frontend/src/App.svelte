<script>
  // import logo from "./assets/images/logo-universal.png";
  import { onMount } from "svelte";
  import "carbon-components-svelte/css/white.css";
  import { ContentSwitcher, Switch } from "carbon-components-svelte";
  import { Run } from "../wailsjs/go/main/App.js";
  import SplitPane from "./components/SplitPane.svelte";
  import Head from "./Head.svelte";
  import Request from "./Request.svelte";
  import Response from "./Response.svelte";
  import Sidebar from "./Sidebar.svelte";
  import AddIcon from "carbon-icons-svelte/lib/Add.svelte";
  import CloseIcon from "carbon-icons-svelte/lib/Close.svelte";

  // 定义单个标签页的默认结构
  const createNewTab = (overrides = {}) => ({
    id: Date.now() + Math.random(),
    title: "New Request",
    method: "GET",
    url: "",
    bodyContent: "",
    contentType: "application/none",
    headers: [{ id: 0, key: "", value: "" }],
    params: [{ id: 0, key: "", value: "" }],
    authData: { type: "none", token: "", username: "", password: "" },
    result: "",
    responseStatus: null,
    responseStatusCode: 0,
    responseSize: 0,
    time: null,
    responseHeaders: null,
    responseContentType: null,
    isLoading: false,
    isError: false,
    errMsg: "",
    selectIndex: 0,
    ...overrides
  });

  let tabs = [createNewTab()];
  let activeTabId = tabs[0].id;
  let history = [];

  $: activeTab = tabs.find(t => t.id === activeTabId) || tabs[0];

  $: {
    if (activeTab) {
        if (activeTab.url && activeTab.url.trim() !== "") {
            try {
                const testUrl = activeTab.url.includes('://') ? activeTab.url : 'http://' + activeTab.url;
                const urlObj = new URL(testUrl);
                let title = urlObj.pathname !== '/' ? urlObj.pathname : urlObj.hostname;
                activeTab.title = title || activeTab.url;
            } catch (e) {
                activeTab.title = activeTab.url;
            }
        } else {
            activeTab.title = "New Request";
        }
    }
    tabs = tabs;
  }

  onMount(() => {
    const savedHistory = localStorage.getItem("hiposter_history");
    if (savedHistory) {
      history = JSON.parse(savedHistory);
    }
  });

  function addTab() {
    const newTab = createNewTab();
    tabs = [...tabs, newTab];
    activeTabId = newTab.id;
  }

  function closeTab(id, event) {
    event.stopPropagation();
    if (tabs.length === 1) {
      tabs = [createNewTab()];
      activeTabId = tabs[0].id;
      return;
    }
    const index = tabs.findIndex(t => t.id === id);
    tabs = tabs.filter(t => t.id !== id);
    if (activeTabId === id) {
      activeTabId = tabs[Math.max(0, index - 1)].id;
    }
  }

  function selectHistory(event) {
    const item = event.detail;
    // 在当前活动的标签页中加载历史记录
    activeTab.method = item.method;
    activeTab.url = item.url;
    activeTab.bodyContent = item.bodyContent || "";
    activeTab.contentType = item.contentType || "application/none";
    activeTab.headers = item.headers || [{ id: 0, key: "", value: "" }];
    activeTab.params = item.params || [{ id: 0, key: "", value: "" }];
    activeTab.authData = item.authData || { type: "none", token: "", username: "", password: "" };
    activeTab.result = "";
    activeTab.responseStatus = null;
    tabs = [...tabs]; // 触发 Svelte 更新
  }

  function deleteHistoryItem(event) {
    const index = event.detail;
    history = history.filter((_, i) => i !== index);
    localStorage.setItem("hiposter_history", JSON.stringify(history));
  }

  function saveHistory(item) {
    history = [item, ...history.filter(h => h.url !== item.url || h.method !== item.method)].slice(0, 50);
    localStorage.setItem("hiposter_history", JSON.stringify(history));
  }

  function getMethodColor(method) {
      const colors = {
          'GET': 'var(--ui-success)',
          'POST': 'var(--ui-warning)',
          'PUT': 'var(--ui-info)',
          'PATCH': 'var(--brand-secondary)',
          'DELETE': 'var(--ui-error)',
          'HEAD': 'var(--ui-text-mute)',
          'OPTIONS': '#0ea5e9',
          'TRACE': '#14b8a6',
          'CONNECT': '#f43f5e'
      };
      return colors[method] || 'var(--ui-text-main)';
  }

  function run() {
    if (!activeTab.method || activeTab.url.length == 0) {
      return;
    }
    activeTab.isLoading = true;
    activeTab.isError = false;
    activeTab.result = "";
    let start = new Date().getTime();

    const finalUrl = activeTab.url;
    const finalBody = activeTab.bodyContent;

    let processedHeaders = activeTab.headers.map(h => ({
      key: h.key,
      value: h.value
    }));

    let finalHeaders = [...processedHeaders.filter(h => h.key.toLowerCase() !== 'authorization')];
    if (activeTab.authData.type === "bearer" && activeTab.authData.token) {
      finalHeaders.push({ key: "Authorization", value: `Bearer ${activeTab.authData.token}` });
    } else if (activeTab.authData.type === "basic" && activeTab.authData.username) {
      const u = activeTab.authData.username;
      const p = activeTab.authData.password;
      const credentials = btoa(`${u}:${p}`);
      finalHeaders.push({ key: "Authorization", value: `Basic ${credentials}` });
    }

    saveHistory({
      method: activeTab.method,
      url: activeTab.url,
      bodyContent: activeTab.bodyContent,
      contentType: activeTab.contentType,
      headers: JSON.parse(JSON.stringify(activeTab.headers)),
      params: JSON.parse(JSON.stringify(activeTab.params)),
      authData: JSON.parse(JSON.stringify(activeTab.authData))
    });

    Run(activeTab.method, finalUrl, finalBody, activeTab.contentType, finalHeaders)
      .then((res) => {
        let end = new Date().getTime();
        activeTab.time = end - start + "ms";
        activeTab.isLoading = false;
        activeTab.responseStatus = res.httpStatus;
        activeTab.responseStatusCode = res.statusCode;
        activeTab.responseSize = res.size;
        activeTab.responseContentType = res.contentType;
        activeTab.responseHeaders = res.headers;
        activeTab.result = res.bodyContent;
        tabs = [...tabs];
      })
      .catch((e) => {
        activeTab.isLoading = false;
        activeTab.isError = true;
        activeTab.errMsg = e.toString();
        tabs = [...tabs];
      });
  }

  let options = ["Params", "Headers", "Body", "Auth"];
  </script>

<div class="app-container">
  <Sidebar {history} on:select={selectHistory} on:clear={() => {history = []; localStorage.removeItem("hiposter_history");}} on:deleteItem={deleteHistoryItem} />
  
  <main class="main-content">
    <div class="header-region">
        <div class="tabs-scroll-container">
            <div class="tabs-bar">
                {#each tabs as tab (tab.id)}
                    <div class="tab-wrapper" style="animation: slideInRight 0.4s ease forwards;">
                        <div class="tab {activeTabId === tab.id ? 'active' : ''}" on:click={() => activeTabId = tab.id}>
                            <div class="tab-status-dot" style="background-color: {getMethodColor(tab.method)}"></div>
                            <span class="tab-method">{tab.method}</span>
                            <span class="tab-title">{tab.title}</span>
                            <div class="tab-close" on:click={(e) => closeTab(tab.id, e)}>
                                <CloseIcon size={14} />
                            </div>
                        </div>
                    </div>
                {/each}
                <div class="add-tab-btn" on:click={addTab} title="New Tab">
                    <AddIcon size={22} />
                </div>
            </div>
        </div>
    </div>

    <div class="workbench-viewport">
        <div class="glass-card workbench-content">
            <Head on:click={run} bind:theMethod={activeTab.method} btnValue={activeTab.isLoading ? "Sending" : "Send"} bind:url={activeTab.url} />
            
            <div class="options-navigation">
                <div class="format-switcher">
                  {#each options as op, i}
                    <button
                        class="format-btn {activeTab.selectIndex === i ? 'active' : ''}"
                        on:click={() => (activeTab.selectIndex = i)}
                    >
                        {op}
                    </button>
                  {/each}
                </div>
            </div>

            <div class="split-pane-container">
              <SplitPane pos={50} fixed={false} min={20} max={80} buffer={100}>
                <div slot="a" class="pane-content anim-fade-in">
                    <Request
                      on:click={() => {
                          let s = "";
                          for (const v of activeTab.params) {
                              if (v.key != "") {
                                  if (s == "") { s += "?" + v.key + "=" + v.value; } 
                                  else { s += "&" + v.key + "=" + v.value; }
                              }
                          }
                          activeTab.url = activeTab.url.split("?")[0] + s;
                      }}
                      bind:bodyContent={activeTab.bodyContent}
                      bind:contentType={activeTab.contentType}
                      bind:headers={activeTab.headers}
                      bind:params={activeTab.params}
                      bind:authData={activeTab.authData}
                      bind:selectIndex={activeTab.selectIndex}
                    />
                </div>
                <div slot="b" class="pane-content anim-fade-in">
                    <Response
                      bind:result={activeTab.result}
                      responseStatus={activeTab.responseStatus}
                      responseStatusCode={activeTab.responseStatusCode}
                      responseSize={activeTab.responseSize}
                      time={activeTab.time}
                      responseHeaders={activeTab.responseHeaders}
                      responseContentType={activeTab.responseContentType}
                      isLoading={activeTab.isLoading}
                      isError={activeTab.isError}
                      errMsg={activeTab.errMsg}
                    />
                </div>
              </SplitPane>
            </div>
        </div>
    </div>
  </main>
</div>

<style>
  .app-container {
    display: flex;
    height: 100vh;
    width: 100vw;
    background-color: var(--ui-bg-base);
    overflow: hidden;
  }
  .main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    position: relative;
  }
  .header-region {
    padding: 16px 24px 8px 24px;
    z-index: 10;
  }
  .tabs-scroll-container {
    display: flex;
    align-items: center;
    overflow-x: auto;
    padding: 6px 4px 10px 4px; /* 增加顶部和底部 padding 防止裁剪位移和阴影 */
    margin-top: -6px; /* 抵消 padding 保持位置感 */
  }
  .tabs-scroll-container::-webkit-scrollbar { display: none; }
  
  .tabs-bar {
    display: flex;
    align-items: center;
    gap: 12px;
  }
  .tab-wrapper {
    perspective: 1000px;
    padding: 2px 0; /* 为悬浮效果留出微小空间 */
  }
  .tab {
    display: flex;
    align-items: center;
    padding: 10px 18px;
    background: rgba(255, 255, 255, 0.4);
    backdrop-filter: blur(8px);
    border: 1.5px solid transparent; /* 使用透明边框占位，防止抖动 */
    border-radius: var(--ui-radius-md);
    cursor: pointer;
    min-width: 130px;
    max-width: 220px;
    gap: 10px;
    transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
    position: relative;
    box-shadow: 0 2px 4px rgba(0,0,0,0.02);
  }
  .tab.active {
    background: var(--ui-bg-card);
    border-color: var(--brand-primary);
    box-shadow: var(--ui-shadow-lg);
    transform: translateY(-2px); /* 稍微明显的悬浮感 */
  }
  .tab:not(.active):hover {
    background: rgba(255, 255, 255, 0.9);
    border-color: rgba(99, 102, 241, 0.2);
    transform: translateY(-1px);
  }
  .tab-status-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
  }
  .tab-method {
    font-size: 10px;
    font-weight: 800;
    color: var(--ui-text-mute);
    letter-spacing: 0.05em;
  }
  .active .tab-method {
    color: var(--brand-primary);
  }
  .tab-title {
    font-size: 13px;
    font-weight: 600;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    color: var(--ui-text-desc);
    flex: 1;
  }
  .active .tab-title {
    color: var(--ui-text-main);
  }
  .tab-close {
    opacity: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 20px;
    height: 20px;
    border-radius: 6px;
    color: var(--ui-text-mute);
    transition: all 0.2s;
  }
  .tab:hover .tab-close {
    opacity: 1;
  }
  .tab-close:hover {
    background: var(--ui-error);
    color: white;
  }
  .add-tab-btn {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: var(--ui-radius-md);
    background: transparent;
    color: var(--ui-text-mute);
    cursor: pointer;
    transition: all 0.2s;
  }
  .add-tab-btn:hover {
    background: var(--ui-bg-card);
    color: var(--brand-primary);
    box-shadow: var(--ui-shadow-sm);
  }
  
  .workbench-viewport {
    flex: 1;
    padding: 0 24px 24px 24px;
    overflow: hidden;
  }
  .workbench-content {
    height: 100%;
    display: flex;
    flex-direction: column;
    padding: 24px;
    animation: fadeIn 0.5s ease;
  }
  .glass-card {
    background: var(--ui-bg-card);
    border-radius: var(--ui-radius-xl);
    border: 1px solid rgba(255, 255, 255, 0.7);
    box-shadow: var(--ui-shadow-float);
  }
  .options-navigation {
    margin: 8px 0 24px 0;
    max-width: 600px;
  }
  .split-pane-container {
    flex: 1;
    position: relative;
    border-radius: var(--ui-radius-lg);
    background: var(--ui-bg-sub);
    padding: 2px;
    overflow: hidden;
  }
  .pane-content {
    height: 100%;
    background: var(--ui-bg-card);
    border-radius: calc(var(--ui-radius-lg) - 2px);
    overflow: hidden;
  }
  .anim-fade-in {
    animation: fadeIn 0.4s ease;
  }
  
  /* 统一导航样式 */
  .format-switcher {
    display: inline-flex;
    background-color: var(--ui-bg-sub);
    padding: 4px;
    border-radius: var(--ui-radius-md);
    border: 1px solid rgba(0,0,0,0.03);
  }
  .format-btn {
    border: none;
    background: transparent;
    padding: 8px 20px;
    font-size: 13px;
    font-weight: 600;
    color: var(--ui-text-mute);
    border-radius: var(--ui-radius-sm);
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
    letter-spacing: 0.02em;
  }
  .format-btn:hover:not(.active) {
    color: var(--ui-text-desc);
  }
  .format-btn.active {
    background-color: var(--ui-bg-card);
    color: var(--brand-primary);
    box-shadow: var(--ui-shadow-sm);
  }
</style>
