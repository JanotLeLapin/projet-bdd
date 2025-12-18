import { readFileSync, writeFileSync } from 'node:fs'

/**
 * @typedef {Object} Section
 * @property {string} name
 * @property {string[]} columns
 * @property {string[][]} rows
 */

/**
 * @param {string[]} chunk
 * @returns {string}
 */
function getNameFromChunk(chunk) {
  const lines = chunk.split('\n')
  return lines[0].split('INSERTING ')[1]
}

/**
 * @param {string[]} chunk
 * @returns {string[]}
 */
function getColumnsFromChunk(chunk) {
  const lines = chunk.split('\n')
  const attrs = lines[1].split('(')[1].split(')')[0]
  return attrs.split(',').map(s => s.trim())
}

/**
 * @param {string} raw
 * @returns {string[]}
 */
function processRow(raw) {
  const res = []
  let current = ''

  let i = 0
  while (i < raw.length) {
    if (raw[i] === "'") {
      i++
      do {
        current += raw[i]
        i++
      } while (raw[i] != "'")
      res.push(current)
      current = ''
      i++
    } else if (raw.slice(i, i + 7) === 'TO_DATE') {
      i += 9
      do {
        current += raw[i]
        i++
      } while (raw[i] != "'")
      res.push(current)
      current = ''
      do {
        i++
      } while (raw[i] != ')')
      i += 1
      // console.log(raw.slice(i, i + 5))
    } else if (raw[i] === ',') {
      if (current.length > 0) {
        res.push(current)
        current = ''
      }
    } else if (raw[i] === ' ') {
    } else {
      current += raw[i]
    }

    i++
  }
  return res
}

/**
 * @param {string[]} chunk
 * @returns {string[][]}
 */
function getRowsFromChunk(chunk) {
  const lines = chunk.split('\n')
  lines.shift()
  const raw = lines
    .filter(line => line)
    .map(line => line.split('VALUES (')[1].split(');')[0])
  return raw.map(processRow)
}

/**
 * @param {string[]} chunk
 * @returns {Section}
 */
function processSection(chunk) {
  const name = getNameFromChunk(chunk)
  const columns = getColumnsFromChunk(chunk)
  const rows = getRowsFromChunk(chunk)

  return {
    name,
    columns,
    rows: rows.filter(row => row.length == columns.length),
  }
}

/**
 * @param {string} path
 * @param {Section} section
 */
function saveSection(path, section) {
  const columns = section.columns.join(',')
  const rows = section.rows.map(row => row.join(',')).join('\n')
  writeFileSync(path, `${columns}\n${rows}`)
}

const data = readFileSync('./dataset.sql', { encoding: 'utf8' })
const chunks = data.split('--')
chunks.shift()

const section = processSection(chunks[1])
saveSection('users.csv', section)
