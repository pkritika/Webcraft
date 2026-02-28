import Foundation

struct PortfolioAssessment: Identifiable {
    let id: Int
    let title: String
    let description: String
    let icon: String
    let color: String // hex color
    let htmlMarker: String

    // Structured instruction fields
    let whatYoureBuilding: String
    let steps: [String]
    let expectedResult: String
    let bonusChallenge: String

    // Code starters
    let starterHTML: String
    let starterCSS: String
    let starterJS: String?

    static let allAssessments: [PortfolioAssessment] = [

        // ── Module 1: About Me Section ──────────────────────────
        PortfolioAssessment(
            id: 1,
            title: "About Me Section",
            description: "Create your portfolio's first page with your name and a short intro",
            icon: "house.fill",
            color: "#6366F1",
            htmlMarker: "<!-- HEADER -->",
            whatYoureBuilding: "Create the very first page of your portfolio with your name, a big welcome heading, and a short paragraph about yourself.",
            steps: [
                "Replace the placeholder `<h1>` with your own name.",
                "Change the `<h2>` to say \"Welcome to my portfolio!\".",
                "Write 2–3 sentences about who you are in the first `<p>`.",
                "Add your grade and one fun fact in the second `<p>`."
            ],
            expectedResult: "Your browser shows a plain white page with your name as the biggest heading at the top, a welcome message below it, and two paragraphs of text about you.",
            bonusChallenge: "Add an `<h3>` \"My Favourite Things\" and use three `<p>` tags to list your top three hobbies, foods, or movies.",
            starterHTML: """
            <!-- HEADER -->
            <section class="header-section">

              <!-- TODO: YOUR TURN — Replace "Your Name Here" with your actual name -->
              <h1>Your Name Here</h1>

              <!-- TODO: YOUR TURN — Change this to say "Welcome to my portfolio!" -->

              <!-- TODO: YOUR TURN — Write 2–3 sentences about who you are -->
              <p></p>

              <!-- TODO: YOUR TURN — Add your grade and one fun fact about yourself -->

            </section>
            """,
            starterCSS: """
            /* ✨ Module 1 — basic page styling */
            body {
                font-family: Arial, Helvetica, sans-serif;
                background: #ffffff;
                color: #222222;
                line-height: 1.6;
            }
            h1 { font-size: 2.5rem; color: #1E1B4B; }
            h2 { font-size: 1.4rem; color: #3730A3; }
            p  { font-size: 1rem; }
            """,
            starterJS: nil
        ),

        // ── Module 2: About ME ──────────────────────
        PortfolioAssessment(
            id: 2,
            title: "About Me",
            description: "Add a \"About Me\" section with CSS colour & fonts",
            icon: "link.circle.fill",
            color: "#BE185D",
            htmlMarker: "<!-- About Me -->",
            whatYoureBuilding: "Add a \"About Me\" section with your description and make your page pop with colour and custom fonts using CSS.",
            steps: [
                "Below your About Me section, add an `<h2>` that says \"About Me\".",
                "In the CSS tab, change the `body` background colour (try `#f0f4ff`) and set a `font-family`.",
                "Change the colour of your `<h1>` heading using the CSS `color` property (try `#2d6be4`).",
                "Add a special character — `&copy;` for © or `&hearts;` for ♥."
            ],
            expectedResult: "Your page now has a colourful background, a styled heading in your chosen colour, and a \"About Me\" section with your description",
            bonusChallenge: "Style links with `a { color: #e91e8c; }` — and remove the underline using `text-decoration: none;`.",
            starterHTML: """
            <!-- LINKS -->
            <section class="about-section">

              <!-- TODO: YOUR TURN — Change "About Me" to your own section title -->
              <h2 class="about-title">About Me</h2>

              <!-- TODO: YOUR TURN — Write 2–3 sentences describing yourself -->
              <p class="about-text">Write something interesting about yourself here...</p>

              <!-- TODO: YOUR TURN — Replace &copy; with &hearts; or try &star; -->
              <p class="about-footer">&copy; Made by Your Name</p>

            </section>
            """,
            starterCSS: """
            /* ---- ABOUT ME STYLES ---- */

            /* STEP 1: Give your section a background colour */
            .about-section {
              /* TODO: YOUR TURN — Change background-color to your favourite colour!
                 Try: #f0f4ff  or  #fff3e0  or  #e8f5e9 */
              background-color: white;
              padding: 40px;
            }

            /* STEP 2: Style your section heading */
            .about-title {
              /* TODO: YOUR TURN — Pick a colour for your heading, try #2d6be4 */
              font-family: Arial, sans-serif;
            }

            /* STEP 3: Style your paragraph text
            TODO: YOUR TURN — Change font-size, try: 18px  and font family*/ */
            
            .about-text {
            }

            /* BONUS: Make your links look cool! */
            /* TODO: YOUR TURN — Uncomment the block below and fill in the values!
            .about-link {
              color: ???;
              text-decoration: none;
              font-weight: bold;
            }
            */
            """,
            starterJS: nil
        ),

        // ── Module 3: Skills Section ────────────────────────────
        PortfolioAssessment(
            id: 3,
            title: "Skills Section",
            description: "Add a \"My Skills\" section using CSS classes, IDs, span, and div",
            icon: "paintbrush.fill",
            color: "#0E7490",
            htmlMarker: "<!-- SKILLS -->",
            whatYoureBuilding: "Add a \"My Skills\" section and move all your CSS into its own separate stylesheet file, keeping your code neat and organised.",
            steps: [
                "Add a `<div class=\"skills-section\">` with an `<h2>` \"My Skills\" inside it.",
                "Use `<span class=\"skill\">` for each skill (e.g. HTML, CSS, Drawing).",
                "In the CSS tab, style `.skills-section` with a background colour and padding.",
                "Style `.skill` with a background colour, `border-radius`, and padding so each looks like a badge chip.",
                "Add `id=\"main-heading\"` to your `<h1>` and style it with `#main-heading { }`."
            ],
            expectedResult: "Your page now has a \"My Skills\" section with colourful badge-style labels for each skill. Each skill chip has its own background colour and padding.",
            bonusChallenge: "Wrap your intro in `<div class=\"intro\">` with a different background colour than the skills section — creating a two-tone page layout!",
            starterHTML: """
            <!-- SKILLS -->
            <div class="skills-section">

              <h2>My Skills</h2>

              <div class="skills-list">
                <!-- TODO: YOUR TURN — Replace these with your real skills!
                     Copy the <span> pattern to add more. -->
                <span class="skill">HTML</span>
                <span class="skill">CSS</span>
                <!-- TODO: YOUR TURN — Add at least 3 more skill chips below -->

              </div>

            </div>
            """,
            starterCSS: """
            /* ---- SKILLS SECTION ---- */

            /* STEP 1: Style the skills section background */
            .skills-section {
              /* TODO: YOUR TURN — Change background-color, try #1a1a2e or #f8fafc */
              background-color: white;
              padding: 40px;
            }

            /* STEP 2: Lay out the skill chips in a row that wraps */
            .skills-list {
              display: flex;
              flex-wrap: wrap;
              gap: 12px;
              margin-top: 16px;
            }

            /* STEP 3: Style each skill chip */
            .skill {
              /* TODO: YOUR TURN — Pick a background-color for your chips, try #6366F1 */
              background-color: lightgray;

              /* TODO: YOUR TURN — Change border-radius to make them rounder, try 20px */
              border-radius: 4px;

              padding: 8px 16px;
              font-weight: bold;
            }

            /* BONUS: Give your h1 a unique style using its ID */
            /* TODO: YOUR TURN — Add id="main-heading" to your <h1> in Module 1,
               then uncomment and fill in the block below!
            #main-heading {
              color: ???;
              font-size: ???;
            }
            */
            """ ,
            starterJS: nil
        ),

        // ── Module 4: Photo Gallery ─────────────────────────────
//        PortfolioAssessment(
//            id: 4,
//            title: "Photo Gallery",
//            description: "Add a gallery of images with captions and a CSS background image",
//            icon: "photo.stack.fill",
//            color: "#B45309",
//            htmlMarker: "<!-- GALLERY -->",
//            whatYoureBuilding: "Add a \"My Gallery\" section that shows off images of things you love — hobbies, places, or your favourite things — with captions.",
//            steps: [
//                "Add a `<div class=\"gallery\">` section with an `<h2>` heading \"My Gallery\".",
//                "Add at least three `<img src=\"...\" alt=\"...\">` images. Always include a meaningful `alt` description!",
//                "Below each image, add a short `<p>` caption describing what it shows.",
//                "In the CSS tab, set `max-width: 300px;` on your images. Add `background-image: url(...);` to your page header area."
//            ],
//            expectedResult: "Your portfolio now has a gallery of images, each sized nicely at around 300px wide with a short caption underneath. All images have helpful alt text for screen readers.",
//            bonusChallenge: "Wrap each image and its caption inside a `<div class=\"gallery-item\">` and in CSS give each item a `border` and a slight `box-shadow` to make them look like photo prints.",
//            starterHTML: """
//            <h1 id="main-heading">Your Name Here</h1>
//            <p>Hi! I'm a student who loves coding and creating things.</p>
//
//            <div class="skills-section">
//                <h2>My Skills</h2>
//                <span class="skill">HTML</span>
//                <span class="skill">CSS</span>
//            </div>
//
//            <!-- ADD YOUR GALLERY SECTION BELOW -->
//            <div class="gallery">
//                <h2>My Gallery</h2>
//
//                <div class="gallery-item">
//                    <img src="https://picsum.photos/seed/webcraft1/300/200" alt="My favourite place" />
//                    <p>My favourite place to visit</p>
//                </div>
//
//                <div class="gallery-item">
//                    <img src="https://picsum.photos/seed/webcraft2/300/200" alt="Something I love" />
//                    <p>Something I love</p>
//                </div>
//
//                <!-- Add more gallery items here -->
//            </div>
//            """,
//            starterCSS: """
//            /* ✨ Module 4 — images & backgrounds */
//            body {
//                font-family: Arial, Helvetica, sans-serif;
//                background: #f0f4ff;
//                color: #222;
//                line-height: 1.6;
//            }
//            #main-heading { color: #2d6be4; font-size: 2.2rem; }
//            h2 { color: #3730A3; }
//
//            .skills-section { background: #e0e7ff; padding: 20px; border-radius: 10px; margin-top: 20px; }
//            .skill { display: inline-block; padding: 6px 14px; margin: 4px; border-radius: 20px; background: #6366F1; color: white; }
//
//            .gallery { margin-top: 30px; }
//            .gallery-item { display: inline-block; margin: 10px; vertical-align: top; }
//            .gallery img { max-width: 300px; border-radius: 8px; display: block; }
//            .gallery p { max-width: 300px; font-size: 0.9rem; color: #555; margin: 6px 0 0; }
//            """,
//            starterJS: nil
//        ),

        // ── Module 5: Resume / CV Table ─────────────────────────
        PortfolioAssessment(
            id: 5,
            title: "Resume / CV Table",
            description: "Add an experience table, an audio player, and convert links to proper lists",
            icon: "tablecells.fill",
            color: "#065F46",
            htmlMarker: "<!-- TABLE -->",
            whatYoureBuilding: "Add a \"My Experience\" table that acts like a mini-resume — showing school activities, achievements, and hobbies in a neat, organised grid.",
            steps: [
                "Add an `<h2>` \"My Experience\" and a `<table>` with at least 4 rows. Use `<th>` for headers (Activity, Description, Year) and `<td>` for data.",
                "Fill the table with real activities: clubs, sports, awards, and classes you enjoy.",
                "Add a \"What I'm Listening To\" `<h2>` with an HTML5 `<audio controls src=\"...\">` tag below it.",
                "Convert your skills into a `<ul>` bullet list and your links into an `<ol>` numbered list."
            ],
            expectedResult: "Your portfolio now has a table with bold header labels and neatly arranged rows of your activities. There's also a small audio player visitors can press play on, and your skills and links are formatted as proper lists.",
            bonusChallenge: "Add an imagemap to one of your gallery photos. Define two or three clickable regions using `<map>` and `<area>` tags that link to different websites when clicked.",
            starterHTML: """
            <!-- TABLE -->
            <div class="table-section">

              <h2 class="table-title">My Experience 📋</h2>

              <table class="resume-table">
                <thead>
                  <tr>
                    <th>Activity</th>
                    <th>Description</th>
                    <th>Year</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- TODO: YOUR TURN — Replace these rows with your real activities!
                       Think: clubs, sports, awards, classes you enjoy. -->
                  <tr>
                    <td>Coding Club</td>
                    <td>Built my first website</td>
                    <td>2024</td>
                  </tr>
                  <tr>
                    <td>Art Class</td>
                    <td>Won the school art competition</td>
                    <td>2023</td>
                  </tr>
                  <!-- TODO: YOUR TURN — Add at least 2 more rows below -->

                </tbody>
              </table>

              <!-- STEP 3: Audio Player -->
              <h2 class="table-title">What I'm Listening To 🎵</h2>
              <!-- TODO: YOUR TURN — Replace the src with a link to your own audio file! -->
              <audio class="audio-player" controls src="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3">
                Your browser does not support the audio element.
              </audio>

              <!-- STEP 4: Skills as a bullet list -->
              <h2 class="table-title">My Skills 🛠️</h2>
              <ul class="skills-ul">
                <li>HTML</li>
                <li>CSS</li>
                <!-- TODO: YOUR TURN — Add your own skills here -->
              </ul>

              <!-- STEP 4: Links as a numbered list -->
              <h2 class="table-title">My Favourite Sites 🔗</h2>
              <ol class="links-ol">
                <li><a href="https://scratch.mit.edu" target="_blank">Scratch</a></li>
                <!-- TODO: YOUR TURN — Add 2 more of your favourite sites here -->
              </ol>

            </div>
""",
            starterCSS: """
            /* ---- RESUME / CV TABLE ---- */

            /* STEP 1: Section background and spacing */
            .table-section {
              background-color: #f0fdf4;
              padding: 40px;
            }

            .table-title {
              color: #065F46;
              margin-top: 32px;
              margin-bottom: 12px;
            }

            /* STEP 2: Style the table itself */
            .resume-table {
              width: 100%;
              border-collapse: collapse;
            }

            /* STEP 3: Style the header row */
            .resume-table th {
              background-color: #065F46;
              color: white;
              padding: 12px 16px;
              text-align: left;
            }

            /* STEP 4: Style the data cells */
            .resume-table td {
              padding: 10px 16px;
              border-bottom: 1px solid #d1fae5;
              /* TODO: YOUR TURN — Change the color of your table text, try #1a1a2e */
              color: black;
            }

            /* STEP 5: Alternating row colours — zebra striping! */
            /* TODO: YOUR TURN — Uncomment the block below to add zebra stripes!
            .resume-table tr:nth-child(even) {
              background-color: #ecfdf5;
            }
            */

            /* STEP 6: Audio player */
            .audio-player {
              display: block;
              margin-top: 8px;
              width: 100%;
              max-width: 400px;
            }

            /* STEP 7: List styles */
            .skills-ul, .links-ol {
              padding-left: 24px;
              line-height: 2;
            }

            /* BONUS: style your list links */
            /* TODO: YOUR TURN — Uncomment and fill in to style your ol links!
            .links-ol a {
              color: ???;
              text-decoration: none;
            }
            */
            """ ,
            starterJS: nil
        ),

        // ── Module 6: Styled Layout ─────────────────────────────
        PortfolioAssessment(
            id: 6,
            title: "Styled Layout",
            description: "Add a sticky header, two-column layout, and interactive hover effects",
            icon: "rectangle.3.group.fill",
            color: "#5B21B6",
            htmlMarker: "<!-- LAYOUT -->",
            whatYoureBuilding: "Transform your portfolio from a plain list of sections into a properly laid-out page with a sticky header, a sidebar, and interactive hover effects.",
            steps: [
                "Add a `<header class=\"site-header\">` with your name and nav links. In CSS: `position: sticky; top: 0;` so it sticks to the top as visitors scroll.",
                "Create `<div class=\"main-content\">` and `<div class=\"sidebar\">`. Use `float: left` / `float: right` with widths of 65% and 30%. Move your skills and links into the sidebar.",
                "Add `.skill:hover { background: #4338CA; }` so skill badges change colour on hover.",
                "Use `tr:nth-child(even) td { background: #e0e7ff; }` for alternating table row colours.",
                "Add proper `padding` and `margin` around each section using the box model so the page doesn't feel cramped."
            ],
            expectedResult: "Your portfolio now looks like a real website! There's a sticky navigation bar at the top, a two-column layout with main content on the left and a sidebar on the right, zebra-striped table rows, and skill badges that change colour when you hover over them.",
            bonusChallenge: "Add `z-index: 100` to your sticky header and give it `background: rgba(255,255,255,0.9)` — then add `backdrop-filter: blur(4px)` for a frosted-glass look!",
            starterHTML: """
            <!-- LAYOUT -->

            <!-- STEP 1: Sticky header with your name and nav links -->
            <header class="site-header">
              <!-- TODO: YOUR TURN — Replace "Your Name" with your actual name -->
              <span class="site-header-name">Your Name</span>
              <nav class="site-header-nav">
                <a href="#about">About</a>
                <a href="#skills">Skills</a>
                <!-- TODO: YOUR TURN — Add 2 more nav links matching your sections -->
              </nav>
            </header>

            <!-- STEP 2: Two-column layout wrapper -->
            <div class="layout-wrapper">

              <!-- LEFT: Main content column -->
              <div class="main-content">
                <!-- TODO: YOUR TURN — Move your About Me and Experience sections inside here -->
                <p class="placeholder-text">👈 Move your main sections in here!</p>
              </div>

              <!-- RIGHT: Sidebar column -->
              <div class="sidebar">
                <!-- TODO: YOUR TURN — Move your Skills and Favourite Links sections in here -->
                <p class="placeholder-text">👈 Move your Skills and Links in here!</p>
              </div>

            </div>

            <!-- Footer -->
            <footer class="site-footer">
              <!-- TODO: YOUR TURN — Replace "Your Name" and update the year -->
              <p>&copy; 2025 Your Name &hearts; Built with HTML &amp; CSS</p>
            </footer>
            """,
            starterCSS: """
            /* ---- STYLED LAYOUT ---- */

            /* STEP 1: Sticky header */
            .site-header {
              position: sticky;
              top: 0;
              display: flex;
              justify-content: space-between;
              align-items: center;
              background-color: #ffffff;
              padding: 16px 32px;
              border-bottom: 2px solid #e0e7ff;

              /* TODO: YOUR TURN — Uncomment for a frosted-glass BONUS effect!
              background: rgba(255, 255, 255, 0.9);
              backdrop-filter: blur(4px);
              z-index: 100; */
            }

            .site-header-name {
              font-weight: bold;
              font-size: 1.2rem;
              color: #5B21B6;
            }

            .site-header-nav {
              display: flex;
              gap: 24px;
            }

            .site-header-nav a {
              text-decoration: none;
              color: #5B21B6;
              font-weight: bold;
            }

            /* STEP 2: Two-column layout using float */
            .layout-wrapper {
              padding: 32px;
              /* TODO: YOUR TURN — Add overflow: hidden to contain the floated columns */
              overflow: hidden;
            }

            .main-content {
              float: left;
              width: 65%;
              /* TODO: YOUR TURN — Add padding-right: 24px to give breathing room */
            }

            .sidebar {
              float: right;
              /* TODO: YOUR TURN — Change width to 30% */
              width: 50%;
              background-color: #f5f3ff;
              border-radius: 12px;
              padding: 20px;
            }

            /* STEP 3: Hover effect on skill badges */
            .skill:hover {
              /* TODO: YOUR TURN — Change the hover background colour, try #4338CA */
              background-color: gray;
              cursor: pointer;
            }

            /* STEP 4: Zebra striping on table rows */
            /* TODO: YOUR TURN — Uncomment the block below! */
            /*
            .resume-table tr:nth-child(even) td {
              background-color: #e0e7ff;
            }
            */

            /* STEP 5: Box model — breathing room on all sections */
            .main-content > * {
              margin-bottom: 32px;
            }

            .sidebar > * {
              margin-bottom: 24px;
            }

            /* Footer */
            .site-footer {
              clear: both;
              text-align: center;
              padding: 24px;
              background-color: #5B21B6;
              color: white;
              margin-top: 40px;
            }
            """,
            starterJS: nil
        ),

        // ── Module 7: Contact Form ──────────────────────────────
        PortfolioAssessment(
            id: 7,
            title: "Contact Form",
            description: "Add a \"Contact Me\" form so visitors can get in touch with you",
            icon: "envelope.fill",
            color: "#1E40AF",
            htmlMarker: "<!-- CONTACT -->",
            whatYoureBuilding: "Add a \"Contact Me\" section at the bottom of your portfolio with a fully working HTML form so visitors can send you their name, email, and a message.",
            steps: [
                "Add an `<h2>` \"Contact Me\" and a `<form method=\"post\" class=\"contact-form\">` tag.",
                "Add a name input: `<input type=\"text\" name=\"name\" placeholder=\"Your name\">` with a `<label>` above it.",
                "Add an email input: `<input type=\"email\" name=\"email\" placeholder=\"your@email.com\">`. The browser validates the format automatically!",
                "Add a `<select name=\"subject\">` dropdown with at least three `<option>` choices.",
                "Add a `<textarea name=\"message\" rows=\"5\">` and a submit button: `<input type=\"submit\" value=\"Send Message\">`."
            ],
            expectedResult: "🎉 Your portfolio is complete! Visitors scroll down to a styled contact form. They can type their name, enter an email, choose a subject from a dropdown, type a message, and click \"Send Message\".",
            bonusChallenge: "Add a `required` attribute to the name, email, and message fields — the browser will automatically block submission if they're left empty! Then add `maxlength=\"500\"` to the textarea.",
            starterHTML: """
            <!-- CONTACT -->
            <section class="contact-section">

              <!-- TODO: YOUR TURN — Change "Contact Me" to your own heading if you like! -->
              <h2 class="contact-title">Contact Me 📬</h2>
              <p class="contact-subtitle">Have a question? Fill out the form and I'll get back to you!</p>

              <form class="contact-form" method="post">

                <!-- STEP 2: Name field -->
                <label class="form-label" for="name">Your Name</label>
                <input class="form-input" type="text" id="name" name="name" placeholder="Your name" />

                <!-- STEP 3: Email field -->
                <!-- TODO: YOUR TURN — Add a <label> and <input type="email"> for email below -->
                <!-- Hint: type="email" makes the browser check the format automatically! -->

                <!-- STEP 4: Subject dropdown -->
                <label class="form-label" for="subject">Subject</label>
                <select class="form-input" id="subject" name="subject">
                  <option value="">-- Pick a subject --</option>
                  <option value="hello">Just saying hi 👋</option>
                  <!-- TODO: YOUR TURN — Add at least 2 more <option> choices below -->

                </select>

                <!-- STEP 5: Message textarea -->
                <!-- TODO: YOUR TURN — Add a <label> and <textarea> for the message below -->
                <!-- Hint: use rows="5" to make it tall enough to type in! -->

                <!-- STEP 5: Submit button -->
                <input class="submit-btn" type="submit" value="Send Message 🚀" />

              </form>

            </section>            
""",
            starterCSS: """
            /* ---- CONTACT FORM ---- */

            /* STEP 1: Section background and spacing */
            .contact-section {
              background-color: #eff6ff;
              padding: 60px 40px;
              /* TODO: YOUR TURN — Try changing background-color to your favourite colour! */
            }

            .contact-title {
              color: #1E40AF;
              font-size: 2rem;
              margin-bottom: 8px;
            }

            .contact-subtitle {
              color: #555;
              margin-bottom: 32px;
            }

            /* STEP 2: Stack the form fields vertically */
            .contact-form {
              display: flex;
              flex-direction: column;
              gap: 10px;
              max-width: 520px;
            }

            /* STEP 3: Label styling */
            .form-label {
              font-weight: bold;
              color: #1E40AF;
              font-size: 0.95rem;
            }

            /* STEP 4: Shared style for all inputs, select, and textarea */
            .form-input {
              padding: 12px 16px;
              border: 2px solid #bfdbfe;
              border-radius: 8px;
              font-size: 1rem;
              outline: none;
              /* TODO: YOUR TURN — Change border-color on focus below! */
            }

            .form-input:focus {
              border-color: #1E40AF;
            }

            /* STEP 5: Submit button */
            .submit-btn {
              padding: 14px;
              background-color: #1E40AF;
              color: white;
              border: none;
              border-radius: 8px;
              font-size: 1.1rem;
              font-weight: bold;
              cursor: pointer;
              margin-top: 8px;
              /* TODO: YOUR TURN — Change background-color to your favourite colour! */
            }

            /* BONUS: Hover effect on the submit button */
            /* TODO: YOUR TURN — Uncomment the block below to add a hover effect!
            .submit-btn:hover {
              background-color: #1d4ed8;
              transform: scale(1.02);
            }
            */
            """,
            starterJS: nil
        )
    ]
}
