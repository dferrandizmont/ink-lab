"""Checks that the retired GitHub Pages site only redirects to inklab.mainshai.com.

The privacy policy is published by the website in web/ (site.toml -> privacy); these pages
keep the old URLs working. Run: python -B web/legal/test_legal.py
"""
import unittest
from pathlib import Path

BASE = Path(__file__).resolve().parent
REDIRECTS = {
    'index.html': 'https://inklab.mainshai.com/',
    'privacidad/index.html': 'https://inklab.mainshai.com/es/privacy/',
    'privacidad/en/index.html': 'https://inklab.mainshai.com/privacy/',
}
PUBLIC = {*REDIRECTS, 'robots.txt', '.nojekyll'}
PRIVATE = {'LEEME.md', 'test_legal.py', '.gitignore'}


class RedirectsTest(unittest.TestCase):
    def test_every_old_page_redirects(self):
        for rel, url in REDIRECTS.items():
            with self.subTest(rel=rel):
                html = (BASE / rel).read_text(encoding='utf-8')
                self.assertIn(f'<meta http-equiv="refresh" content="0; url={url}">', html)
                self.assertIn(f'<link rel="canonical" href="{url}">', html)
                self.assertIn(f'href="{url}"', html.split('<body>', 1)[1])
                self.assertNotIn('<script', html)

    def test_no_stray_files(self):
        files = {p.relative_to(BASE).as_posix() for p in BASE.rglob('*')
                 if p.is_file() and '__pycache__' not in p.parts and 'dist' not in p.parts}
        self.assertEqual(files, PUBLIC | PRIVATE)


if __name__ == '__main__':
    unittest.main()
