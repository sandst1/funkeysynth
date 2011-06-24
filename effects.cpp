/*
 * FunkeySynth - A synthesizer application for MeeGo tablets
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
#include "effects.h"

#include "wah.h"
#include "reverb.h"
#include "flanger.h"
#include "phaser.h"

Effects::Effects(QDeclarativeContext* context, QObject *parent) :
    QObject(parent), m_effects()
{
    m_effects[0] = new Wah(this);
    m_effects[1] = new Reverb(this);
    m_effects[2] = new Flanger(this);
    m_effects[3] = new Phaser(this);

    context->setContextProperty("Wah", (Wah*)(m_effects[0]));
}

Effects::~Effects()
{
    for (int i = 0; i < EFFECTS_AMOUNT; i++)
    {
        delete m_effects[i];
    }
}

void Effects::setWah(bool state)
{
    m_effects[Effect::WAH]->setState(state);
}

void Effects::setReverb(bool state)
{
    m_effects[Effect::REVERB]->setState(state);
}

void Effects::setPhaser(bool state)
{
    m_effects[Effect::PHASER]->setState(state);
}

void Effects::setFlanger(bool state)
{
    m_effects[Effect::FLANGER]->setState(state);
}

void Effects::apply(float& sample)
{
    for (int i = 0; i < EFFECTS_AMOUNT; i++)
    {
        m_effects[i]->apply(sample);
    }
}
