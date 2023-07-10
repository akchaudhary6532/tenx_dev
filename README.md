# 10ex.dev Take Home Project

> **Note**
>This is designed to be done with Elixir specifically, but if you have talked with 10ex.dev about using a different programming language that you are more comfortable, stick with that.

## Getting started

> We recommend to fork this repository to your GitHub account before you get started, which makes it much easier to hand in the solution when you are done.

## Prerequisites

You will need the following installed on your machine

- Ensure you have Elixir 1.14 and Erlang/OTP 25 installed. We recommend using [asdf](https://asdf-vm.com/), in which case you can use the `.tool-versions` 
file in this repository, to setup your development environment.

- PostgreSQL - You will need a local database, either PostgreSQL on your machine, 
or have Docker installed so we can create a PostgreSQL container. If you want to 
use docker, make sure it is installed -- https://docs.docker.com/get-docker/

- Review the docs of the Marvel API https://developer.marvel.com/documentation/generalinfo.

- You will have to signup for a free account to get an API key. Go to http://developer.marvel.com/ 
and click on "Get a Key" in the header.

- Please have your public and private key from the "My Developer Account" page copied and ready 
to go. The URL is https://developer.marvel.com/account. If you are getting 500 errors, just click 
that link directly.

- Add the public and private key to your config/dev.secret.exs file in this project.

## Up and Running

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- `docker-compose up -d` (If using docker for PostgreSQL)
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `iex -S mix phx.server --open`


> **Note**
> There is nothing special about this application,
> so if you get stuck you can always have a look at the [official Phoenix docs](https://hexdocs.pm/phoenix/1.7.1/installation.html).

## Assignment

This assignment consists of 9 different steps, that are functionally related,and build upon each other.
For this assignment you have to clone this repository,
get the application running locally and then work on the code,
as you would with any other Elixir/Phoenix application.

### What is and isn't expected

- We don't expect you to complete all the steps.
The main goal of the assignment is to have some code we can talk about in our next call.
We don't want to use more of your free time than absolutely necessary.
The assignment is intended to take **up to 4 hours**, but not more.

- You do not need to do the setps in the exact order they are listed.

- The application should work out of the box.
No show-stopper kind of programming errors have been intentionally added to it.
However, we expect you to **fix any application/logic errors** that you come across.
We would love to discuss them in our next call.

- We expect you to do **local refactorings and small code improvements** as you see fit.
However, do not focus on the HTML/CSS/JS part of the application, unless absolutely necessary.
This is an Elixir assignment after all.

- Last but not least we expect you to **use Git** during the assignment.
Put your changes into appropriately sized commits,
just as if you were working in a collaborative environment. We will review these commits and 
changes as part of the pair review session. 


## Goals
  1. Fetch the characters from the Marvel API. Hint: You will use the URL
  http://gateway.marvel.com/v1/public/characters?[authenticated_params]

  2. Render the characters' names in a list on the UI with LiveView or via a controller and view.

  3. This is slow, every time we load the page, we need to fetch all the data again from the Marvel
  API. Let's implement a cache that stores this API call in memory so we don't need to keep
  fetching it on each page reload.

  4. Upper management really wants to know how often we are making requests to the Marvel API, so
  let's capture the timestamp of each successful API call into a database table.

  5. You will notice that the API is only giving us the first 20 results when we call it. Let's implement a
  pagination system to allow the users to see additional results in the UI. How does this affect our cache? Should we change anything?

  6. Let's add more test coverage. We want to mock the API calls, test the front end results, unit test
  the api authentication code, etc.

  7. What are some ways that we can improve the current code we just wrote? Think through the following:
  - Cache improvements (invalidation, pre-fetching, data optimization, handling api call failures, etc).
  - Improvements to the API interface.

8. Now let's deploy this to fly.io. It is free to make an account and deploy a starter application. Follow their [getting started guide](https://fly.io/docs/elixir/getting-started/existing/).


## Handing in the solution

- Once you are done, ensure you committed and pushed all your changes, and then you can send your solution directly by email to [jobs@10ex.dev](mailto:jobs@10ex.dev?subject=10ex.dev%20Elixir%20Assignment), for example, as a zip archive. Please make sure the solution contains the entire project, including the `.git` directory, so we can have a look at your commits.

- [Schedule a follow up review call](https://meetings.hubspot.com/garrett-tacoronte/technical-review-call) to go over your final implementation.