# WordGrowth
#### Video Demo: https://youtu.be/anLsciraAtg
#### Description:
WordGrowth is a study tool for intermediate to advanced language learners of any language.

When trying to learn new vocabulary at higher levels it is useful to have real life examples to refer to to improve retention of the new vocabulary. 

The objective of the tool is for learners to make a note of new words that they encounter, and to add real life examples of the word to the tool either in video or text format.

## Features
- Register an account
- Change password on account
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

## Design desicions

I used an app.py file for the main python code and a helpers.py file for functions to help with the parsing of the youtube url, highlighting of key words in articles, connecting the database, and error messages. A number of templates were used for the different pages in the site.

In my sqlite3 database there are 2 tables, one for users containing their log in information and id, and one for vocabualry that has been input by the users, with a user id foreign key connecting the two tables. There is no pre-inserted vocab in the tables, it is all user created.

I used bootstrap version 5 for the styling. This was to keep the app simple and focus on the main purpose of the app which is to render the real life content for the learner in the card view which is contained in a file called word_view.

I decided to keep the main page a list of the words along with the definition and example sentence. To view the real world example it is necessary to click into the word to view it. There is no button or instruction for this, but it should be obvious to the user that this is how it works. The table containing the words is designed with hover and pointer animation to indicate that clicking on the word will give more detail.

Once in the word view page the user can either click done to return to the main table, edit to make changes to the entry, or delete to remove the word.

The edit word page functions so as to not update existing content when edits are made to other fields by using an either or variable when inserting the edited information into the database. This makes sure that information is not wiped when updates are made.

When entering a new word in the new word page, it is possible to add only the word and definition and leave all the other fields blank to create an entry. These other fields can be added later in edit.

I wanted the real life media input field to be the same for both the articles and video content, so this meant coding if statements for the content type after it had been ascertained by a separate funtion. This media type is then stored in the database along with the url or text. Ideally, I would like the article url to be inserted into the field and the clipping from the article to be automatically generated and included in the word view. This requires some additional program instillations and will be a good update for future versions of the app.

The challenge for the video embedding was to make sure the youtube urls embed properly with the correct timestamp. This required a function in helpers that extracted both the video id and the timestamp and pieces them back together when the word page is launched. 

Following are some future improvements that could be made.

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