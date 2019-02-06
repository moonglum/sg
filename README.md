# Rails & Atomic Design

based upon https://www.innoq.com/en/blog/rails-frontend-components
but adjusted to atomic design

## `data`

The blogpost had the explicit concept of `data` that is checked for
a contract. In this approach it is optional. You can do it like
this:

Caller:
```erb
This is <%= atom :strong, data: { text: "good" } %>.
```

Called:

```erb
<%
    text = data.fetch(:text)
%>
<strong><%= text %></strong>
```

## Variant

This drops the concept of variant. I think it was not a good idea
in hindsight.

## JS & CSS

This ignores JS and CSS, because it doesn't need to worry about it.
But the suggestion is to put them into the folders with the name
`index.js` and `index.scss` to make it easy to import them.
But this is left to tools like faucet.

## TODO

[aiur](https://github.com/moonglum/aiur/) like documentation generator.

## Gemify?

Should this be the `aiur` gem?

### Atomic Design?

Maybe make the words atom, molecule etc. optional. This could work
by not including the helpers, only the `component` helper and only
generating the four helpers so it can be modified. Same for the
controller helper.
