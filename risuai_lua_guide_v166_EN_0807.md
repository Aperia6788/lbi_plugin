# RisuAI Lua Triggers Complete Guide v166 - 2025

## Lua Trigger System Overview

RisuAI's Lua Trigger system is a powerful scripting environment that allows handling various events within conversations. It operates in a Lua 5.4-based environment executed through JavaScript, enabling chat interaction automation and custom behavior implementation.

### System Features
- **Lua 5.4 Based**: Supports latest Lua language features
- **JavaScript Execution**: Performance considerations due to JavaScript execution layer
- **Sandboxed Environment**: No file system or network access
- **External Libraries**: Only `json.lua` included
- **Event-Driven**: Responds to various chat events

---

## 1. Callback Functions

Main callback functions available in all Lua trigger scripts.

### Basic Callback Functions

| Function | Trigger Point | Parameters | Description |
|----------|---------------|------------|-------------|
| `onStart(triggerId)` | Chat sent | `triggerId`: Trigger identifier | Called when user sends message |
| `onOutput(triggerId)` | AI response received | `triggerId`: Trigger identifier | Called when AI generates response |
| `onInput(triggerId)` | User input received | `triggerId`: Trigger identifier | Called when user input is received |

### Button Event Callbacks
```lua
-- When using {{button::Display::TriggerName}}
function TriggerName(triggerId)
    -- Code to execute when button is clicked
end
```

### Edit Event Listeners
```lua
listenEdit(type, callback)
```

**Supported Types:**
- `editRequest`: Request editing
- `editDisplay`: Display editing  
- `editInput`: Input editing
- `editOutput`: Output editing

**Callback Function Format:**
```lua
listenEdit("editDisplay", function(triggerId, data)
    -- Edit processing logic
    return modifiedData
end)
```

---

## 2. Logging and Debugging

### Logging Functions
| Function | Description | Usage | Limitations |
|----------|-------------|-------|-------------|
| `log(message)` | RisuAI defined logging function (JSON format) | `log({key = "value"})` | May not work in certain environments |
| `print(message)` | Lua standard logging function | `print("simple text")` | **Recommended for reliability** |

**💡 Tip:** If `log` function doesn't work, use `print` function for debugging as it's more stable in the execution environment.

---

## 3. Variable Management

### Chat Variables

| Function | Description | Limitations |
|----------|-------------|-------------|
| `setChatVar(triggerId, key, value)` | Set chat variable | value must be string, **Safe Access required** |
| `getChatVar(triggerId, key)` | Get chat variable value | - |

### Global Variables

| Function | Description | Limitations |
|----------|-------------|-------------|
| `getGlobalVar(triggerId, key)` | Get global variable value | Returns null if undefined |

### State Variables - **Recommended**

| Function | Description | Limitations |
|----------|-------------|-------------|
| `setState(triggerId, key, value)` | Set state variable | value must be JSON serializable |
| `getState(triggerId, key)` | Get state variable value | - |

**💡 Recommendation:** `setState`/`getState` supports more data types and is preferred over `setChatVar`/`getChatVar`.

---

## 4. User Interface

### Alert Functions

| Function | Description | Return Value | Limitations |
|----------|-------------|--------------|-------------|
| `alertError(triggerId, message)` | Show error alert | - | **Safe Access required** |
| `alertNormal(triggerId, message)` | Show normal alert | - | **Safe Access required** |
| `alertInput(triggerId, message)` | Show input alert and get user input | Input value | **Safe Access required** |
| `alertSelect(triggerId, options)` | Show selection alert with options array | Selected option | **Safe Access required** |

### Display Control

| Function | Description | Limitations |
|----------|-------------|-------------|
| `reloadDisplay(triggerId)` | Reload GUI display | **Safe Access required** |
| `reloadChat(triggerId, index)` | Reload specific chat message at index | **Safe Access required** |

### Chat Control

| Function | Description | Limitations |
|----------|-------------|-------------|
| `stopChat(triggerId)` | Stop chat | **Safe Access required**, Only works on certain events |

---

## 5. Chat Manipulation

### Basic Chat Manipulation

| Function | Description | Parameters | Limitations |
|----------|-------------|------------|-------------|
| `getChat(triggerId, index)` | Get message at specified index | index: 0-based | - |
| `setChat(triggerId, index, message)` | Set message at specified index | index: 0-based | **Safe Access required** |
| `setChatRole(triggerId, index, role)` | Set role at specified index | role: "user" or "char" | **Safe Access required** |
| `removeChat(triggerId, index)` | Remove message at specified index | - | **Safe Access required** |
| `cutChat(triggerId, start, end)` | Cut messages from start to end | - | **Safe Access required** |

### Chat Addition/Insertion

| Function | Description | Parameters | Limitations |
|----------|-------------|------------|-------------|
| `addChat(triggerId, role, message)` | Add new message | Appends to end of chat | **Safe Access required** |
| `insertChat(triggerId, index, role, message)` | Insert message at specified position | - | **Safe Access required** |

### Chat Information Retrieval

| Function | Description | Return Value | Limitations |
|----------|-------------|--------------|-------------|
| `getChatLength(triggerId)` | Get total message count | Number | - |
| `getFullChat(triggerId)` | Get full chat history | Array of message objects | - |
| `setFullChat(triggerId, chat)` | Set entire chat history | - | **Safe Access required** |

### Message History Retrieval

| Function | Description | Return Value | Limitations |
|----------|-------------|--------------|-------------|
| `getCharacterLastMessage(triggerId)` | Get the last message from character | String | **Returns first message if no character messages found** |
| `getUserLastMessage(triggerId)` | Get the last message from user | String or null | Returns null if no user message found |

**Message Object Structure:**
```lua
{
    role = "user" or "char",
    data = "message content",
    time = timestamp or 0
}
```

---

## 6. Character Management

### Basic Character Information

| Function | Description | Return/Set Value | Limitations |
|----------|-------------|------------------|-------------|
| `getName(triggerId)` | Get current character name | String | **Async - requires `:await()`** |
| `setName(triggerId, name)` | Set character name | - | **Safe Access required, Async - requires `:await()`** |
| `getDescription(triggerId)` | Get character description | String | **Safe Access required, Async - requires `:await()`, Not for groups** |
| `setDescription(triggerId, description)` | Set character description | - | **⚠️ BROKEN - DO NOT USE** |

**⚠️ Critical Bug:** The `setDescription` function is currently broken due to a variable reference error in the source code (references `data` instead of `desc` parameter). Do not use this function until it's fixed.

### Advanced Character Information

| Function | Description | Return/Set Value | Limitations |
|----------|-------------|------------------|-------------|
| `getCharacterFirstMessage(triggerId)` | Get character's first message | String | **Async - requires `:await()`** |
| `setCharacterFirstMessage(triggerId, message)` | Set character's first message | - | **Safe Access required, Async - requires `:await()`** |
| `getBackgroundEmbedding(triggerId)` | Get background embedding | Embedding data | **Safe Access required, Async - requires `:await()`** |
| `setBackgroundEmbedding(triggerId, embedding)` | Set background embedding | - | **Safe Access required, Async - requires `:await()`** |

### Persona Information

| Function | Description | Return Value | Limitations |
|----------|-------------|--------------|-------------|
| `getPersonaName(triggerId)` | Get current persona name | String | - |
| `getPersonaDescription(triggerId)` | Get current persona description (CBS parsed) | String | - |

### Chat Metadata

| Function | Description | Return Value | Limitations |
|----------|-------------|--------------|-------------|
| `getAuthorsNote(triggerId)` | Get current chat's author note | String | - |

---

## 7. Lorebook Management

### Lorebook Search and Loading

| Function | Description | Parameters | Return Value | Limitations |
|----------|-------------|------------|--------------|-------------|
| `getLoreBooks(triggerId, search)` | Return all lorebooks with comment field matching search | `search`: Lorebook comment to search for | Array of lorebook objects | - |
| `loadLoreBooks(triggerId, reserve)` | Return currently active lorebooks within context limits | `reserve`: Token count to reserve | Array of lorebook objects | **Low Level Access required, Already awaited - DO NOT use `:await()`** |

### Lorebook Management

| Function | Description | Parameters | Limitations |
|----------|-------------|------------|-------------|
| `upsertLocalLoreBook(triggerId, name, content, options)` | Create or update local lorebook entry | `name`: Comment/name, `content`: Content, `options`: Configuration object | **Safe Access required** |

**upsertLocalLoreBook Options:**
```lua
{
    alwaysActive = false,      -- Always active flag
    insertOrder = 100,         -- Priority value
    key = '',                  -- Activation keyword
    secondKey = '',            -- Secondary keyword
    regex = false              -- Use regex for keys
}
```

### Lorebook Data Structure

#### `getLoreBooks` Return Object:
- `content`: Lorebook content (CBS parsed)
- `comment`: Lorebook name/description
- `key`: Activation keyword array
- `priority`: Priority value
- `alwaysActive`: Always active flag
- Other lorebook metadata

#### `loadLoreBooks` Return Object:
- `data`: Parsed lorebook content
- `role`: Message role ("user", "char", "system")

---

## 8. Advanced Features (Requires Low Level Access)

### ⚠️ **CRITICAL: Async Function Usage**

**Functions that require `:await()` (TypeScript declared as async):**
- `similarity(triggerId, source, value):await()`
- `request(triggerId, url):await()`
- `generateImage(triggerId, prompt, negative):await()`
- `simpleLLM(triggerId, prompt):await()`
- `getTokens(triggerId, text):await()`
- `hash(triggerId, text):await()`

**Functions with internal await handling (DO NOT use `:await()`):**
- `LLM(triggerId, messages)` - **Already awaited internally**
- `axLLM(triggerId, messages)` - **Already awaited internally**
- `loadLoreBooks(triggerId, reserve)` - **Already awaited internally**

### Language Model Integration

| Function | Description | Parameters | Return Value | Limitations |
|----------|-------------|------------|--------------|-------------|
| `LLM(triggerId, messages)` | LLM request using main model | `messages`: Message array | LLM response object | **Low Level Access required, Already awaited - DO NOT use `:await()`** |
| `axLLM(triggerId, messages)` | LLM request using auxiliary model | `messages`: Message array | LLM response object | **Low Level Access required, Already awaited - DO NOT use `:await()`** |
| `simpleLLM(triggerId, prompt)` | Simple LLM request with single prompt | `prompt`: String prompt | LLM response object | **Low Level Access required, Async - requires `:await()`** |

**Message Format for LLM Functions:**
```lua
{
    {role = "system", content = "System message"},
    {role = "user", content = "User message"},
    {role = "assistant", content = "Assistant message"}  -- or "char", "bot"
}
```

**LLM Response Object:**
```lua
{
    success = true/false,
    result = "response text" or "error message"
}
```

### Other Advanced Functions

| Function | Description | Parameters | Return Value | Limitations |
|----------|-------------|------------|--------------|-------------|
| `similarity(triggerId, source, value)` | Perform similarity sorting | `source`: Array, `value`: String | Sorted array | **Low Level Access required, Async - requires `:await()`** |
| `generateImage(triggerId, prompt, negative)` | Generate image | `prompt`: String, `negative`: String (optional) | Image asset CBS | **Low Level Access required, Async - requires `:await()`** |
| `request(triggerId, url)` | HTTP GET request | `url`: HTTPS URL only | `{status: number, data: string}` | **Low Level Access required, Async - requires `:await()`** |

**HTTP Request Security Restrictions:**
- **HTTPS Only**: Only HTTPS URLs allowed
- **URL Length**: Maximum 120 characters
- **Rate Limiting**: 5 requests per minute
- **Banned Domains**: risuai.net, risuai.xyz, realm.risuai.net

### Utility Functions

| Function | Description | Parameters | Return Value | Limitations |
|----------|-------------|------------|--------------|-------------|
| `getTokens(triggerId, text)` | Calculate token count of string | `text`: String to tokenize | Token count (number) | **Safe Access required, Async - requires `:await()`** |
| `hash(triggerId, text)` | Generate hash value of string | `text`: String to hash | Hash string | **Async - requires `:await()`** |

---

## 9. Async Helper Functions

### Async Wrapper

```lua
async(callback)
```
- **Description**: Wrapper function for creating asynchronous operations
- **Usage**: Wrap callback functions that need async behavior
- **Return Value**: Promise-like object

---

## 10. Access Level Requirements

### Always Available Functions
Functions available in all trigger modes (no access restrictions):
- `log` and `print`
- `setState`/`getState`
- `getChatVar`
- `getGlobalVar`
- `getChat`
- `getChatLength`
- `getFullChat`
- `getPersonaName`
- `getPersonaDescription`
- `getAuthorsNote`
- `getCharacterLastMessage`
- `getUserLastMessage`
- `getLoreBooks`

### Safe Access Required Functions
Functions requiring Safe Access (not available in editDisplay mode):
- `setChatVar`
- `setChat`
- `setChatRole`
- `addChat`
- `insertChat`
- `removeChat`
- `cutChat`
- `setFullChat`
- `stopChat`
- `alertError`
- `alertNormal`
- `alertInput`
- `alertSelect`
- `reloadDisplay`
- `reloadChat`
- `setName` (**Async**)
- `getDescription` (**Async**)
- `setDescription` (**Broken**)
- `setCharacterFirstMessage` (**Async**)
- `getBackgroundEmbedding` (**Async**)
- `setBackgroundEmbedding` (**Async**)
- `upsertLocalLoreBook`
- `getTokens` (**Async**)

### Low Level Access Required Functions
Functions requiring Low Level Access (advanced permissions):
- `similarity` (**Async**)
- `request` (**Async**)
- `generateImage` (**Async**)
- `LLM` (**Already awaited**)
- `axLLM` (**Already awaited**)
- `simpleLLM` (**Async**)
- `loadLoreBooks` (**Already awaited**)

### Functions with Async Behavior

**Require `:await()` (TypeScript async functions):**
- `getName(triggerId):await()`
- `setName(triggerId, name):await()`
- `getDescription(triggerId):await()`
- `getCharacterFirstMessage(triggerId):await()`
- `setCharacterFirstMessage(triggerId, message):await()`
- `getBackgroundEmbedding(triggerId):await()`
- `setBackgroundEmbedding(triggerId, embedding):await()`
- `getTokens(triggerId, text):await()`
- `hash(triggerId, text):await()`
- `similarity(triggerId, source, value):await()` (Low Level Access)
- `request(triggerId, url):await()` (Low Level Access)
- `generateImage(triggerId, prompt, negative):await()` (Low Level Access)
- `simpleLLM(triggerId, prompt):await()` (Low Level Access)

**DO NOT use `:await()` (Internal await handling):**
- `LLM(triggerId, messages)` - Already awaited in Lua wrapper
- `axLLM(triggerId, messages)` - Already awaited in Lua wrapper
- `loadLoreBooks(triggerId, reserve)` - Already awaited in Lua wrapper

---

## 11. Performance Optimization

### Key Performance Considerations

#### 1. Async Function Usage
```lua
-- ✅ Correct async usage
function onStart(triggerId)
    local name = getName(triggerId):await()
    local firstMsg = getCharacterFirstMessage(triggerId):await()
    print("Character: " .. name .. ", First message: " .. firstMsg)
end

-- ❌ Wrong async usage - will cause errors
function onStart(triggerId)
    local name = getName(triggerId)  -- Missing :await()
    local response = LLM(triggerId, messages):await()  -- Don't use :await()
end
```

#### 2. Minimize Async Calls
```lua
-- ❌ Inefficient: Multiple async calls in loop
function processChat(triggerId)
    for i = 0, getChatLength(triggerId) - 1 do
        local name = getName(triggerId):await()  -- Called every iteration
    end
end

-- ✅ Efficient: Cache async results
function processChat(triggerId)
    local name = getName(triggerId):await()  -- Called once
    for i = 0, getChatLength(triggerId) - 1 do
        -- Use cached name
    end
end
```

---

## 12. Practical Examples

### Basic Async Function Usage

```lua
function onStart(triggerId)
    -- Correct async usage
    local charName = getName(triggerId):await()
    local firstMessage = getCharacterFirstMessage(triggerId):await()
    
    print("Character: " .. charName)
    print("First message: " .. firstMessage)
end
```

### LLM Usage (Pre-awaited Functions)

```lua
function onOutput(triggerId)
    -- Correct - no :await() needed
    local response = LLM(triggerId, {
        {role = "user", content = "Hello"}
    })
    
    if response.success then
        addChat(triggerId, "system", "AI said: " .. response.result)
    end
end
```

### Advanced Async Operations

```lua
function onStart(triggerId)
    -- Multiple async operations
    local name = getName(triggerId):await()
    local tokenCount = getTokens(triggerId, "test message"):await()
    local hashValue = hash(triggerId, "unique data"):await()
    
    setState(triggerId, "analysis", {
        name = name,
        tokens = tokenCount,
        hash = hashValue
    })
end
```

### Safe vs Low Level Access Example

```lua
function onOutput(triggerId)
    -- Safe Access functions
    local lastChar = getCharacterLastMessage(triggerId)
    local lastUser = getUserLastMessage(triggerId)
    
    -- This would require Low Level Access
    -- local similarity = similarity(triggerId, {lastChar}, lastUser):await()
    
    if lastUser and #lastUser > 100 then
        addChat(triggerId, "system", "[Long message detected]")
    end
end
```

---

## 13. Troubleshooting Guide

### Common Async/Await Issues

#### 1. Missing :await() on Async Functions
```lua
-- ❌ Error: Missing :await()
function onStart(triggerId)
    local name = getName(triggerId)  -- This will fail
end

-- ✅ Correct
function onStart(triggerId)
    local name = getName(triggerId):await()
end
```

#### 2. Using :await() on Pre-awaited Functions
```lua
-- ❌ Error: Using :await() on pre-awaited function
function onOutput(triggerId)
    local response = LLM(triggerId, messages):await()  -- This will fail
end

-- ✅ Correct
function onOutput(triggerId)
    local response = LLM(triggerId, messages)  -- Already awaited internally
end
```

#### 3. Access Level Errors
```lua
-- ❌ This will fail in editDisplay mode
function onStart(triggerId)
    setChat(triggerId, 0, "new message")  -- Requires Safe Access
end

-- ✅ Check access level
function onStart(triggerId)
    local message = getChat(triggerId, 0)  -- Always available
    print("Message: " .. (message and message.data or "none"))
end
```

### Debugging Async Functions

```lua
function debugAsyncFunctions(triggerId)
    print("=== Async Function Debug ===")
    
    -- Test async functions with proper await
    pcall(function()
        local name = getName(triggerId):await()
        print("✓ getName works: " .. name)
    end)
    
    pcall(function()
        local firstMsg = getCharacterFirstMessage(triggerId):await()
        print("✓ getCharacterFirstMessage works: " .. firstMsg:sub(1, 50))
    end)
    
    -- Test pre-awaited functions without await
    pcall(function()
        local response = LLM(triggerId, {{role = "user", content = "test"}})
        print("✓ LLM works: " .. (response.success and "success" or "failed"))
    end)
end
```

---

## 14. Known Issues and Bugs

### Critical Bugs

1. **`setDescription()` Function**: Completely broken - references `data` instead of `desc` parameter
2. **Duplicate Function Declarations**: Some functions declared multiple times in source code

### Async/Await Issues

1. **Mixed Async Patterns**: Some functions use internal await, others require external await

### Recommended Workarounds

```lua
-- For setDescription bug - use alternative approach
function setCharacterDescription(triggerId, newDesc)
    -- Cannot use setDescription due to bug
    -- Store in state instead
    setState(triggerId, "customDescription", newDesc)
    alertNormal(triggerId, "Description stored in state due to setDescription bug")
end
```

---

## 15. Version History

### v166 Changes
- **Fixed async/await documentation**: Accurately reflects TypeScript source code
- **Corrected function signatures**: All parameters and return values verified
- **Updated access level requirements**: Based on actual source code implementation
- **Added critical bug warnings**: Clearly marked broken functions
- **Improved troubleshooting**: Added async-specific debugging tips

**⚠️ Breaking Changes from Previous Versions:**
- Many functions now correctly marked as requiring `:await()`
- `LLM`, `axLLM`, `loadLoreBooks` should NOT use `:await()`

---