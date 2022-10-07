//
//  ViewElementComponent+Example1+JamesEnsorWidegt.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/29.
//

import Foundation

extension ViewElementComponent {
    static let example1_JamesEnsorWidget: ViewElementComponent = {
        .vStack(elements: [
            .hStack(elements: [
                .vStack(elements: [
                    .text(content: "James Ensor", fontStyle: ARVisFontStyle(size: 50, weight: .bold)),
                    .text(content: "FLEMISH PAINTER, ENGRAVER, WRITER, AND MUSICIAN", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                    .text(content: "**Born**: April 13, 1860 - Ostend, Belgium",
                          fontStyle: ARVisFontStyle(size: 22)),
                    .text(content: "**Died**: November 19, 1949 - Ostend, Belgium",
                          fontStyle: ARVisFontStyle(size: 22)),
                    .text(content: "**Movements and Styles**: [Realism](https://www.theartstory.org/movement/realism/), [Impressionism](https://www.theartstory.org/movement/impressionism/), [Neo-Impressionism](https://www.theartstory.org/movement/neo-impressionism/), [Expressionism](https://www.theartstory.org/movement/expressionism/)",
                          fontStyle: ARVisFontStyle(size: 22)),
                    example1_JamesEnsorLifeChartViewElementComponent,
                ], alignment: .leading, spacing: 4),
                .spacer,
                .image(url: "https://uploads8.wikiart.org/images/james-ensor.jpg", height: 300),
            ], alignment: .top, spacing: 8),
            .divider(),
            .hStack(elements: [
                .spacer,
                .segmentedControl(items: [
                    ARVisSegmentedControlItem(title: "Introduction", component: .vStack(elements: [
                        .text(content: "Summary of James Ensor", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                        .vStack(elements: [
                            .text(content: "Although educated in traditional painting, Ensor quickly stepped off that path and began to develop a revolutionary style that reflected his own take on modern life. He was particularly fascinated with the popular carnival culture organized around the celebration of Mardi Gras each year throughout Belgium, most certainly influenced by the fact that his family's shop in Ostend was a main purveyor of carnival paraphernalia. The imagery he produced is consistently cynical and mocking; presenting an almost grotesque form of [Realism](https://www.theartstory.org/movement/realism/) meant to record the stresses underlying contemporary social morays of his time, and probably of all times."),
                        ]),
                        .divider(opacity: 0.2),
                        text(content: "Accomplishments", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                        .vStack(elements: [
                            .hStack(elements: [
                                .text(content: "1️⃣"),
                                .text(content: "Ensor developed a revolutionary method of painting better suited to his personal agenda. Abandoning the usage of illusionism and one-point perspective to organize the image depicted, he began to build volume with patches of color across the surface of the canvas. The effect was imagery that no longer receded but instead, threatened to enter the viewer's space. Crowded to the point of bursting, denied room to breathe, the figures in Ensor's works impress with their presence.\n"),
                                .spacer,
                            ], alignment: .top),
                            .hStack(elements: [
                                .text(content: "2️⃣"),
                                .text(content: """
                                 The artist was particularly intrigued by the carnival theme and found it an excellent means by which to capture society's foibles. He masked his figures, giving them faces that would express their inner selves rather than their outer, anatomical ones. In this way he was able to dig beneath the surface and reveal the "true face" of society. His exploration of society unmasked eventually caused his rejection by many, even the local avant-garde artists.\n
                                """),
                                .spacer,
                            ], alignment: .top),
                            .hStack(elements: [
                                .text(content: "3️⃣"),
                                .text(content: "Ensor's social commentary, at first subtle, eventually took on a furiously cynical tone. While it could be noted in the inclusion of a jesting element within an image it could also be a full-blast attack on a subject as sacred as the Entrance of Christ into Jerusalem. There's no question that the artist's continual feeling of rejection was responsible for his frenzied critiques, but the end result was simply further alienation.\n"),
                                .spacer,
                            ], alignment: .top),
                        ]),
                        .divider(opacity: 0.2),
                        .text(content: "Introduction Video", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                        .hStack(elements: [
                            .spacer,
                            .vStack(elements: [
                                .video(url: "https://www.youtube.com/watch?v=rC3K-b31hCA", height: 400),
                                .text(content: "Life and Art of James Ensor with Christian Conrad - Join Dr. Christina Conrad for a lecture about the life and art of James Ensor.", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                            ]),
                            .spacer,
                        ]),
                    ], alignment: .leading, spacing: 8)),
                    ARVisSegmentedControlItem(
                        title: "Progression of Art",
                        component: .vStack(elements: [
                            .text(content: "1883 - Portrait of the Painter in a Flowered Hat",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_1.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "_Portrait of the Painter_ in a Flowered Hat represents Ensor in a three-quarter view, openly confronting the viewer's gaze. His use of loose, feathery brushstrokes and the juxtaposition of colored areas on the canvas to suggest volume and the emphasis on differentiating light in order to suggest depth, typify the contemporary portraiture work of the Impressionists who were already painting in Belgium and Holland from the 1870s.\n"),
                                    .text(content: "Like many artists before him, Ensor received great inspiration from the tradition of the great masters. This portrait recalls the Flemish painter Peter Paul Rubens' _Self-Portrait_ with Hat, (1623-25). Despite the vague similarities between the two images they actually differ quite a bit and there is a clear sense that Ensor is making a joke of the tradition of the old master who he ostensibly emulates. The hat he sports, adorned with pastel flowers and feathers, was part of a traditional Belgian costume worn by women during the mid-lent carnival. And although the facial hair seems close to that of Rubens', he works blue flame-like whiskers into his mustache in a very untraditional manner. Although both depicted figures have an intense expression, suggesting something of their state of mind, Ensor alleviates the unhappy set of his own mouth with the gaiety of the hat.\n"),
                                    .text(content: """
                                    This painting's light-hearted motifs represent a transition in Ensor's work from his "somber period" to his "light period;" the move from Realism to some form of whimsical reality. It marks the beginning of his experimentation with playful subjects and alternate meanings.\n
                                    """),
                                    .text(content: "Oil on canvas - Ensor Museum, Ostend, Belgium", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                            .text(content: "1889 - Christ's Entry into Brussels",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_2.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "_Portrait of the Painter_ in a Flowered Hat represents Ensor in a three-quarter view, openly confronting the viewer's gaze. His use of loose, feathery brushstrokes and the juxtaposition of colored areas on the canvas to suggest volume and the emphasis on differentiating light in order to suggest depth, typify the contemporary portraiture work of the Impressionists who were already painting in Belgium and Holland from the 1870s.\n"),
                                    .text(content: "Like many artists before him, Ensor received great inspiration from the tradition of the great masters. This portrait recalls the Flemish painter Peter Paul Rubens' _Self-Portrait_ with Hat, (1623-25). Despite the vague similarities between the two images they actually differ quite a bit and there is a clear sense that Ensor is making a joke of the tradition of the old master who he ostensibly emulates. The hat he sports, adorned with pastel flowers and feathers, was part of a traditional Belgian costume worn by women during the mid-lent carnival. And although the facial hair seems close to that of Rubens', he works blue flame-like whiskers into his mustache in a very untraditional manner. Although both depicted figures have an intense expression, suggesting something of their state of mind, Ensor alleviates the unhappy set of his own mouth with the gaiety of the hat.\n"),
                                    .text(content: """
                                    This painting's light-hearted motifs represent a transition in Ensor's work from his "somber period" to his "light period;" the move from Realism to some form of whimsical reality. It marks the beginning of his experimentation with playful subjects and alternate meanings.\n
                                    """),
                                    .text(content: "Oil on canvas - The J. Paul Getty Museum, Los Angeles, California", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                            .text(content: "1890 - The Baths at Ostend",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_3.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "Here, Ensor draws a whimsical scene, paying homage to his beloved Ostend Sea. By this time the town of Ostend had become a seaside resort, known for its casino, boardwalk, beach, and restorative baths. Ensor uses colored pencils, crayons, and oil to represent this quirky vacation spot. He adds a decorative effect by describing the water and figures with arabesque lines which resolve into a sea of caricatures, drawn on multiple planes, representing the seaside resort as a crowded spectacle. Ensor refrains from using linear perspective and instead, draws his figures across the canvas with a restricted palette of black, blue and red, creating a dream-like space.\n"),
                                    .text(content: "In total, Ensor represents this summer playground for the middle-class in a satirical manner. He paints the tourists as caricatures. While overall the scene depicted seems to be a happy one, a sunny day where tourists are enjoying themselves, it also depicts them missing clothing, and a few of which are shown upside down with their heads between their legs- in the midst of vulgar acts. Accordingly, when viewed up close, this painting takes on a somewhat comic and most definitely unsettling effect, it runs counter to the social decorum expected of the bourgeoisie. Ensor's work offers a very clear critique of the contemporary social milieu in which he lived, anticipating movements like Dadaism.\n"),
                                    .text(content: "Black crayon, colored pencil and oil on panal - Fondation Challenges, Paris, France", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                            .text(content: "1888 - The Baths at Ostend",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_4.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "_Masks Confronting Death_ exemplifies Ensor's usage of masks to reveal the underside of society. Although the instigation for including this prop may have come with his awareness of them in his family's shop, he was most probably attracted to their ability to both hide the specific identity of the figure depicted and simultaneously add a note of intrigue and mystery. In this case the masked figures are even scarier than the figure of Death at the center. In fact, shrouded in a white garment and tucked under a hat, Death seems almost cowering in the face of society's mockery. The appearance of masks within early modern art increased around the turn of the century, as their ability as expressive tools was understood. While Ensor's masks are more mocking in nature, primitive masks were noted in works by Gauguin, Derain, and Picasso.\n"),
                                    .text(content: "In this image Death looks out at the viewer, actually confronting her with his gaze.\n"),
                                    .text(content: "Ensor was struggling with the recent death of his father at the time the work was created and his inclusion of the motif may indicate his attempt to deal with his own mortality.\n"),
                                    .text(content: "Oil on canvas - The Museum of Modern Art, New York, New York", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                            .text(content: "c. 1910, backdated to 1896 - The Vengeance of Hop Frog",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_5.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "This work represents Edgar Allan Poe's short story, _The Vengeance of Hop Frog_ (1845) wherein the title character, a court-jester, is the victim of social and class injustice inflicted by the king and clergy. Ensor chooses to illustrate the final scene of the story when Hop-Frog exacts his revenge on the king and clergy at a masquerade ball, stringing them up on a chandelier, above the party, and setting them on fire.\n"),
                                    .text(content: """
                                    Ensor represents a whimsical scene filled with expressive, arabesque lines and pastel colors. Furthermore, the artist uses linear perspective to create a feeling of depth, capturing the enormity of receding space by framing the scene in an arched theatre. Many of the figures are grotesque, broken up in such a way that they appear more abstract concepts of human beings than realistic representations of the same. \n
                                    """),
                                    .text(content: "Beyond offering a satirical way to highlight the dark side of political and religious figures within modern society, Ensor's representation of Poe's story suggests his frustration at receiving unfair and cruel judgment on the part of contemporary critics. In general, Ensor's dependence on literature as a source of inspiration for his work aligns him with other Symbolist artists at the time like van Gogh and Gauguin.\n"),
                                    .text(content: "Oil on canvas - Kröller-Müller Museum, Otterlo, Netherlands", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                            .text(content: "1887 - The Temptation of Saint Anthony",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_6.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "Ensor's painting represents Anthony the Great of Egypt (c. 251-356) resisting the temptations of the devil. The monumental painting includes fifty-one sheets of paper, mounted side by side on canvas. It is assumed that the individual drawings, varied in nature but all with acidic color bound by line in a volume-defying style, were part of a book of drawings inspired by Flaubert's narrative. By representing Saint Anthony surrounded by surreal figures, including, a multi-breasted goddess, a sphinx, nude women, bourgeois men, and musical instruments the artist makes a bold statement regarding the depravity of modern society.\n"),
                                    .text(content: "Representing Saint Anthony's battle with the devil may have been Ensor's response to the temptations and ethical concerns of modern society. Ensor specialist Susan M. Canning suggests that the symbolism included in the painting, elements such as distortion, exaggeration and the macabre, would have been easily identifiable to the 19th century viewer as indicators of the degeneracy of humanity within modern society.\n"),
                                    .text(content: "Colored pencils and scraping, with graphite, charcoal, pastel and water color, selectively fixed, with cut and paste elements on fifty-one sheets of paper, mounted on canvas - The Art Institute of Chicago", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                            .text(content: "1891 - Skeletons Fighting over a Pickled Herring",
                                  fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                            .hStack(elements: [
                                .image(url: "https://www.theartstory.org/images20/works/ensor_james_7.jpg?1", width: 500),
                                .vStack(elements: [
                                    .text(content: "This painting depicts two skeletal figures fighting over a pickled herring in an amorphous landscape with pastel sky. The sky engulfs the two figures, whose dark tones make them stand out against the background - infusing the work with a lighthearted, comical nature. While the feathery brushstrokes and palette of the sky somewhat recall Impressionism, the fantastic, grotesque subject in a no-man's land actually anticipates much later takes on reality, such as found in Surrealism.\n"),
                                    .text(content: """
                                    The painting represents the two critics: Édouard Fétis and Max Sulberger. Their negative responses to Ensor's artwork drove him to portray them in multiple satirical paintings. In this particular work Ensor represents himself as a pickled herring being torn apart by their hateful criticism. The word herring in French, hareng-saur-close, if said with the proper pronunciation, apparently sounded like "art Ensor" or "Ensor's art."\n
                                    """),
                                    .text(content: """
                                    Ensor's intention here, as in many of his other works, was clear: "My favorite occupation is to make others famous, to uglify them, to enrich their ugliness." Ensor discovered an iconography of the grotesque that best enabled him to comment on the injustice and superficiality by which he was surrounded. His development of the macabre was part and parcel of his revelation of society's malaise.\n
                                    """),
                                    .text(content: "Oil on canvas - Musées Royaux des Beaux-Arts de Belgique, Brussels", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                                ], alignment: .leading),
                            ], alignment: .top, spacing: 16),
                            .divider(opacity: 0.2),
                        ], alignment: .leading)
                    ),
                    ARVisSegmentedControlItem(title: "Related Work", component: .grid(rows: [
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEzNTU4NSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=735729b6201042cb"),
                                .text(content: "Cathedral", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1886", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE0OTgzOCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=9043f7a23eeaf279"),
                                .text(content: "Tribulations of Saint Anthony", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1887", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY0NSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=fbc4f06f00009249"),
                                .text(content: "Devil's Sabbath", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1887", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEyMjc5MyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=073a2126d3735068"),
                                .text(content: "House on the Boulevard Anspach", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEyMjc5NyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=6868ed2b576f495a"),
                                .text(content: "Capture of a Strange Town", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEyMjc5OCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=2668be64bd7b2dc6"),
                                .text(content: "The Winds", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE0OTgzMyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=fd0f6f974dc10303"),
                                .text(content: "Masks Confronting Death", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE3OTk0NSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=b31009944f81a1e5"),
                                .text(content: "Stars in the Cemetery", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEzNTU2NiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a72c48b84f3aa49c"),
                                .text(content: "Peculiar Insects", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY1NCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=0123e2bbb376326b"),
                                .text(content: "Devils Thrashing Angels and Archangels", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE0MDUzMCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=ddeb4c0aaf54153e"),
                                .text(content: "Small Bizarre Figures", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY0OSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=e20fdf6c45ae50bc"),
                                .text(content: "Combat of the Rascals Désir and Rissolé", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE3OTgyMyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=ae4d39ba26d62157"),
                                .text(content: "The Terrible Archer", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY0MCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=f2fbcd7305eff795"),
                                .text(content: "The Haunted Furniture (Le meuble hanté)", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU4NiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=4317bbb4b5b0c61b"),
                                .text(content: "The Gendarmes", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjY0Njg4Il0sWyJwIiwiY29udmVydCIsIi1xdWFsaXR5IDcwIC1yZXNpemUgMzcyeDM3Mlx1MDAzZSJdXQ.jpg?sha=4bc9e339436ef479"),
                                .text(content: "The Assassination", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU3NiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a602689519d0abac"),
                                .text(content: "The Assassination", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEyMjgxNSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=29e8833c685a0a05"),
                                .text(content: "Roman Victory", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1889", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU3NyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a257b796485512a4"),
                                .text(content: "The Fantastic Ball", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1889", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEzNTU4NCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=100f84b5a550cf48"),
                                .text(content: "My Portrait as a Skeleton", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1889", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjEyMjc5NCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a19a6c9347913e1f"),
                                .text(content: "The Music in the Rue de Flandre, Ostend", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1890", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE3OTkwNiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=c48af401e37b8ae5"),
                                .text(content: "The Multiplication of the Fishes", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1891", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY1MCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=c2a4be9e0c8c0722"),
                                .text(content: "Windmill at Slykens", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1891", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU3OCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a5065e61b39bd409"),
                                .text(content: "Auto-da-Fé", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1893", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY0MSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=eb229e93f0e26639"),
                                .text(content: "Demons Teasing Me", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE3OTkxNCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=0b070cbf7dc24fe0"),
                                .text(content: "The Battle of the Golden Spurs", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU4MCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=eb653993773297b7"),
                                .text(content: "Fridolin and Gragapança of Yperdamme", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjUxNzY1MyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a1ef1463c12c26ca"),
                                .text(content: "The Bad Doctors", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU4MSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=5c32188a09632fdc"),
                                .text(content: "Christ Descending to Hell", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY1MSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=d7bcd1213d0450f4"),
                                .text(content: "The Old Rascals", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTUwMiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=e412d6f86373a8d5"),
                                .text(content: "King Pest", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1895", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjUxNzc0MyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=be94129ea84cfe29"),
                                .text(content: "Death Chasing the Flock of Mortals", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1896", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU4MiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=47f90a29a24b95ef"),
                                .text(content: "The Scoundrels", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1896", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjIxNTA3NiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=ed4fe4467906edaf"),
                                .text(content: "Self Portrait with Demons", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1898", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjIxMDIwNyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=d32c3dc1186d45ee"),
                                .text(content: "The Entrance of Christ into Brussels (L'Entrée du Christ à Bruxelles)", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1898", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU2NCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=84daa1ba1eddf0d9"),
                                .text(content: "Hop-Frog's Revenge", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1898", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjIzMzE5NyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=157b24971e6edb4f"),
                                .text(content: "Hop-Frog's Revenge", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1898", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0MzI2OSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=950e94a119a48674"),
                                .text(content: "The Baths at Ostend", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1899", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY1MiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=389ef9ba6c415b60"),
                                .text(content: "The Queen Parysatis", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1900", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE3OTk1OSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=2f4870920a06ebbc"),
                                .text(content: "Sloth", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1902", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTY1MyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=11a63d47db3ab86d"),
                                .text(content: "The Beach at La Panne", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0MzY5NyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a8f02f968efc7fa6"),
                                .text(content: "The Deadly Sins", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888–1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0MzY5NyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=a8f02f968efc7fa6"),
                                .text(content: "The Deadly Sins Dominated by Death", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0NDA1MCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=3ad7f493b8d7bebe"),
                                .text(content: "Gluttony", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0MzY5OCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=707f02a8b96ff95b"),
                                .text(content: "Sloth", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1902", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0NDA1MSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=c29d4d92d0c134d9"),
                                .text(content: "Pride", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0MzY5OSJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=f6ce50a1b9d3cc90"),
                                .text(content: "Anger", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0NDA1MiJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=67547e0e5f48bc20"),
                                .text(content: "Avarice", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0NDA1MyJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=795cefb7f2225cea"),
                                .text(content: "Envy", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1904", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjI0NDA1NCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=7896a5112ba93ec3"),
                                .text(content: "Lust", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1888 (portfolio published 1904)", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                        .gridRow(rowElements: [
                            .vStack(elements: [
                                .image(url: "https://www.moma.org/media/W1siZiIsIjE4MTU5MCJdLFsicCIsImNvbnZlcnQiLCItcXVhbGl0eSA3MCAtcmVzaXplIDM3MngzNzJcdTAwM2UiXV0.jpg?sha=de09c7bea5a657f5"),
                                .text(content: "Carnival at Ostende", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                                .text(content: "1931", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                            ]),
                        ]),
                    ])),
                ]),
                .spacer,
            ]),
        ], alignment: .leading, spacing: 4)
    }()
}
