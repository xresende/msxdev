
class MSXBasic:
    """."""

    TOKENS = {
        'AUTO': 169, 'AND': 246, 'ABS': 6, 'ATN': 14, 'ASC':21, 'ATTR$': 233,
        'BASE': 201, 'BSAVE': 208, 'BLOAD': 207, 'BEEP': 192, 'BIN$': 29,
        'CALL': 202, 'CLOSE': 180, 'COPY': 214, 'CONT': 153, 'CLEAR': 146,
        'CLOAD': 155, 'CSAVE': 154, 'CSRLIN': 232, 'CINT': 30, 'CSNG': 31,
        'CVI': 40, 'CVS': 41, 'CLS': 159, 'GOTO': 137, 'GO TO': 137,
        }

    class Line:
        """."""

        def __init__(self, line):
            self._line = line
            self._number = None
            self._bytes = self.get_bytes(line)

        def to_string(self):
            return self._line

        def get_bytes(self, line):
            linebytes = list()
            line = line.lstrip().rstrip()
            # line number
            i = 0
            while (ord('0') <= ord(line[i]) <= ord('9')):
                i += 1
            self._number = int(line[:i])
            linebytes += MSXBasic.Line.conv_addr2lowhigh(self._number)
            line = line[i:]
            print('line  : |{}|'.format(line))

            tokens = MSXBasic.TOKENS
            i1 = 0
            while i1 < len(line):
                if line[i1].isnumeric:
                    raise ValueError('Undefined line number')
                elif not line[i1].isalpha():
                    print('adding: |{}|'.format(line[i1]))
                    linebytes.append(ord(line[i1]))
                    i1 += 1
                    continue
                not_found_token = True
                for i2 in range(i1+1, len(line)):
                    substr = line[i1:i2].upper()
                    if substr in tokens:
                        not_found_token = False
                        token = tokens[substr]
                        i1 = self.add_token(token, line, substr, i2, linebytes)
                        break                         
                if not_found_token:
                    for char in line[i1:]:
                        print('adding: |{}|'.format(char.upper()))
                        linebytes.append(ord(char))
                    break
            linebytes.append(0)

            return linebytes
                

# if line[i1].numeric():
#                     # it is 
#                     i2 = i1 + 1
#                     while i2 < len(line) and line[i2].isnumeric():
#                         i2 += 1
#                     substr = line[i1:i2]
#                     if substr:
#                         linenr = int(substr)
#                         low, hig = MSXBasic.Line.conv_addr2lowhigh(linenr)
#                         print('adding: ', line[i1:i2])
#                         linebytes += [0x0E, low, hig]
#                         i1 = i2

        def add_token(self, token, line, substr, i, linebytes):
            print('token : ', substr, token)
            linebytes.append(token)
            if token in (137, 141):
                substra = ''
                while line[i].isnumeric():
                    substra += line[i]
                    i += 1
                int(substra)
            return i

        def __str__(self):
            """."""
            stn = ''
            for byt in self._bytes:
                stn += ' {:02X}'.format(byt)
            return stn

        @staticmethod
        def conv_addr2lowhigh(number):
            low = number & 0xFF
            hig = (number & 0xFF00) >> 8
            return low, hig

    def __init__(self, org=None):
        """."""
        self._org = org or 0x8000
        self._fname = None
        self._lines = list()

    @property
    def lines(self):
        return self._lines

    def load_basic(self, fname=None, text=None):
        """."""
        if text is None:
            with open(fname, 'r') as fp:
                text = fp.read()
        text = text.splitlines()
        self._fname = fname
        for line in text:
            if line:
                self._lines.append(MSXBasic.Line(line))

    def to_string(self):
        stn = ''
        for line in self._lines:
            if stn:
                stn += '\n' + line.to_string()
            else:
                stn += line.to_string()
        return stn
