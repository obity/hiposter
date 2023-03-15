<script>
    import "carbon-components-svelte/css/white.css";
    import {
        Button,
        Tabs,
        Tab,
        TabContent,
        InlineNotification,
        ProgressBar,
    } from "carbon-components-svelte";
    import BodyOutput from "./responses/bodyOutput.svelte";
    import HeadersOutput from "./responses/headersOutput.svelte";
    import JsonEditor from "./components/JsonEditor.svelte";

    export let result;
    export let responseStatus = "";
    export let responseHeaders;
    export let responseContentType;
    export let time;
    export let isLoading = false;
    export let isError = false;
    export let errMsg = "";
    let outputType = "raw";
</script>

<div class="response" style="position:absolute; width: 100%;height: 100%;">
    {#if result}
        <div class="status">
            <span>Status:</span><span class="statusValue">{responseStatus}</span
            >
            <span>Time:</span> <span class="statusValue">{time}</span>
        </div>

        <div style="position:relative;top: -15px;height:100%;width:99.35%">
            <Tabs autoWidth>
                <Tab label="Body" />
                <Tab label="Headers" />

                <svelte:fragment slot="content">
                    <TabContent style="padding:8px">
                        <Button
                            on:click={() => (outputType = "raw")}
                            kind="tertiary"
                            size="small"
                            style="font-size: small;width:10px;border-radius: 20px;text-align:center"
                            >Raw</Button
                        >
                        <Button
                            on:click={() => (outputType = "pretty")}
                            kind="tertiary"
                            size="small"
                            style="font-size: small;width:10px; margin-bottom: 5px;border-radius: 20px;text-align:center"
                            >Pretty</Button
                        >
                        <div>
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
                    </TabContent>
                    <TabContent
                        ><HeadersOutput
                            bind:headers={responseHeaders}
                        /></TabContent
                    >
                </svelte:fragment>
            </Tabs>
        </div>
    {:else if isLoading}
        <ProgressBar size="sm" helperText="Loading..." />
    {:else}<div style="width:100%;">
            <span>Response</span>
            {#if isError}
                <InlineNotification
                    lowContrast
                    kind="error"
                    title="Error:"
                    timeout={5000}
                    subtitle={errMsg}
                />
            {/if}
        </div>
    {/if}
</div>

<style>
    .status {
        text-align: right;
        position: relative;
        top: 10px;
        left: -10px;
    }
    .response {
        border: 1px solid silver;
        text-align: left;
    }
    .statusValue {
        color: green;
        padding: 5px;
    }
</style>
