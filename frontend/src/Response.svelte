<script>
    import "carbon-components-svelte/css/white.css";
    import {
        Button,
        InlineNotification,
        ProgressBar,
    } from "carbon-components-svelte";
    import BodyOutput from "./responses/bodyOutput.svelte";
    import HeadersOutput from "./responses/headersOutput.svelte";
    import JsonEditor from "./components/JsonEditor.svelte";

    export let result;
    export let responseStatus = "";
    export let responseStatusCode = 0;
    export let responseSize = 0;
    export let responseHeaders;
    export let responseContentType;
    export let time;
    export let isLoading = false;
    export let isError = false;
    export let errMsg = "";
    let outputType = "raw";
    let activeTab = "body";

    function getStatusColor(code) {
        if (code >= 200 && code < 300) return "var(--ui-success)";
        if (code >= 300 && code < 400) return "var(--ui-info)";
        if (code >= 400) return "var(--ui-error)";
        return "var(--ui-text-main)";
    }

    function formatBytes(bytes) {
        if (bytes === 0) return '0 B';
        const k = 1024;
        const sizes = ['B', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }
</script>

<div class="response">
    {#if result}
        <div class="status">
            <span>Status:</span><span class="statusValue" style="color: {getStatusColor(responseStatusCode)}">{responseStatus}</span>
            <span>Time:</span> <span class="statusValue">{time}</span>
            <span>Size:</span> <span class="statusValue">{formatBytes(responseSize)}</span>
        </div>

        <div style="flex:1; padding: 16px 24px; overflow: hidden; display: flex; flex-direction: column;">
            
            <div class="options-navigation" style="margin-bottom: 16px;">
                <div class="format-switcher">
                    <button
                        class="format-btn {activeTab === 'body' ? 'active' : ''}"
                        on:click={() => (activeTab = "body")}
                    >
                        Body
                    </button>
                    <button
                        class="format-btn {activeTab === 'headers' ? 'active' : ''}"
                        on:click={() => (activeTab = "headers")}
                    >
                        Headers
                    </button>
                </div>
            </div>

            <div class="response-content-wrapper" style="flex: 1; overflow: hidden; display: flex; flex-direction: column;">
                {#if activeTab === "body"}
                    <div style="display: flex; flex-direction: column; height: 100%;">
                        <div class="sub-filter-switcher" style="margin-bottom: 10px; align-self: flex-start;">
                            <button
                                class="sub-filter-btn {outputType === 'raw' ? 'active' : ''}"
                                on:click={() => (outputType = "raw")}
                            >
                                Raw
                            </button>
                            <button
                                class="sub-filter-btn {outputType === 'pretty' ? 'active' : ''}"
                                on:click={() => (outputType = "pretty")}
                            >
                                Pretty
                            </button>
                        </div>
                        <div style="flex: 1; border: 1px solid rgba(0,0,0,0.05); border-radius: var(--ui-radius-md); overflow: hidden; background: var(--ui-bg-card);">
                            {#if outputType == "pretty" && responseContentType.startsWith("application/json")}
                                <JsonEditor
                                    value={JSON.stringify(
                                        JSON.parse(result),
                                        null,
                                        4
                                    )}
                                />
                            {:else}
                                <BodyOutput {result} />
                            {/if}
                        </div>
                    </div>
                {:else if activeTab === "headers"}
                    <div style="height: 100%;">
                        <HeadersOutput bind:headers={responseHeaders} />
                    </div>
                {/if}
            </div>
        </div>
    {:else if isLoading}
        <div style="padding: 40px;">
            <ProgressBar size="sm" helperText="Loading..." />
        </div>
    {:else}
        <div style="flex:1; display:flex; align-items:center; justify-content:center; color: var(--ui-text-mute); flex-direction: column; gap: 16px;">
            <div style="font-size: 48px; opacity: 0.2;">📡</div>
            <span style="font-weight: 500;">Waiting for response...</span>
            {#if isError}
                <div style="padding: 0 24px; width: 100%;">
                    <InlineNotification
                        lowContrast
                        kind="error"
                        title="Request Failed"
                        subtitle={errMsg}
                    />
                </div>
            {/if}
        </div>
    {/if}
</div>

<style>
    .status {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 20px;
        padding: 12px 24px;
        font-size: 13px;
        background-color: rgba(0,0,0,0.02);
        border-bottom: 1px solid rgba(0,0,0,0.05);
    }
    .response {
        border-radius: var(--ui-radius-lg);
        overflow: hidden;
        background-color: var(--ui-bg-card);
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .statusValue {
        font-weight: 700;
        margin-left: 6px;
    }
    .status span:not(.statusValue) {
        color: var(--ui-text-desc);
        font-weight: 500;
    }

    .format-switcher {
        display: inline-flex;
        background-color: var(--ui-bg-sub);
        padding: 4px;
        border-radius: var(--ui-radius-md);
        margin-bottom: 16px;
        border: 1px solid rgba(0,0,0,0.03);
    }
    .format-btn {
        border: none;
        background: transparent;
        padding: 6px 16px;
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

    /* 二级级轻量滤镜 (Secondary Filter) */
    .sub-filter-switcher {
        display: inline-flex;
        gap: 4px;
        padding: 2px;
        border-radius: var(--ui-radius-sm);
    }
    .sub-filter-btn {
        border: none;
        background: transparent;
        padding: 4px 12px;
        font-size: 11px;
        font-weight: 600;
        color: var(--ui-text-mute);
        border-radius: var(--ui-radius-sm);
        cursor: pointer;
        transition: all 0.2s ease;
    }
    .sub-filter-btn:hover:not(.active) {
        color: var(--ui-text-desc);
        background: rgba(0,0,0,0.02);
    }
    .sub-filter-btn.active {
        background-color: rgba(99, 102, 241, 0.1); /* 极淡的品牌色背景 */
        color: var(--brand-primary);
    }
</style>
