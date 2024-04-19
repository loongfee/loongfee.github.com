def text_to_m3u8_with_genres(input_file, output_file):
    """Converts a text file with genre sections and media URLs to an M3U8 playlist.

    Args:
        input_file (str): Path to the input text file.
        output_file (str): Path to the output M3U8 file.
    """

    with open(input_file, 'r', encoding='utf-8') as infile, open(output_file, 'w', encoding='utf-8') as outfile:
        outfile.write("#EXTM3U\n")
        current_genre = None

        for line in infile:
            line = line.strip()
            if not line:
                continue  # Skip empty lines

            if line.startswith("🦄") or line.startswith("👉"):  # Genre line
                current_genre = line.strip("👉👈,🦄🐯")  # Extract genre
                continue

            if ',' in line:  # Media line
                title, media_url = line.split(',', 1)
                if current_genre:
                    title = f"{current_genre} - {title}"  # Combine genre and title
                outfile.write(f"#EXTINF:-1,{title}\n")
                outfile.write(f"{media_url}\n")
                
input_file = 'DIYP-v4.txt'
output_file = 'DIYP-v4.m3u8'
text_to_m3u8_with_genres(input_file, output_file)