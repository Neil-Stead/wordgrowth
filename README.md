# WordGrowth
#### Video Demo:  <URL HERE>
#### Description:
WordGrowth is a study tool for intermediate to advanced language learners of any language. The objective of the tool is for learners to make a note of new words that they encounter, and to add real life examples of the word to the tool either in video or text format.

## Features
- Add new vocabulary words with definitions and example sentences
- Attach YouTube videos or article excerpts for real-world usage
- Highlight keywords inside article excerpts
- Edit or delete words from your list
- Secure login and user-based word storage

## Usage

- Navigate to `/register` to create a new account
- Use `/login` to login - persistant login is available
- Add new words using the `/new_word` form
- Add word definitions and / or example sentences using the `/new_word` form
- Paste YouTube links (timestamps supported) or copy text from articles into the realworld example field in the using the `/new_word` form
- View, edit, and delete words through your word list on the `/index` page

## Built With

- Python / Flask
- SQLite3
- Jinja2 templating
- Bootstrap 5 (for styling)

## Roadmap

- [ ] Add additional realworld examples for multiple examples in one card
- [ ] Automated pulling of article excerpts from user input url
- [ ] Add search bar for index page
- [ ] Implement spaced repetition algorithm
- [ ] AI generated definitions and example sentences
- [ ] Avatar and social features for users
- [ ] Sharing of words and examples between users

## Author

Built by Neil Stead https://github.com/neil-stead