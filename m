Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A991258B1
	for <lists+linux-mmc@lfdr.de>; Tue, 21 May 2019 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfEUUMs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 May 2019 16:12:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfEUUMs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 May 2019 16:12:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so54262pgm.7
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2019 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=nGAz3/K7nDgzHUkL2D1i6CIQezGgnUsjYzvazG8X9DqvbZi0EVhUOGAifW2QuFKnvb
         LPbgTo9xZkZKG/71s03GLv/A/1Pg8SVuwZu0XzfrlwB5uV9srfccGrKOE0nkFASqsHkz
         FADTnbSOk/bhT92J9sej8s/kKgurOQRgWuvwOijz4gwS3WpI0tO32QLhXNzrJu/vl80J
         SImh5Q8d/8LpBUNpY8cPuudNDGJG+tpId07FLeBfDDRPbBWFCtta5M8dtAx9y3LdlFP4
         4SgyHSHbpnu+FW6O67mG4izAbM3V/24rAyt83xuCC7FYypjs6RJKO9g/vi0NkNEm2r9E
         gTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=UU0wb38mgwAd+FrJ/wP7tbOtbDLJb7UJIQQo+joxK9HBZEYH5OoNIyrVgeTgE4Q0rJ
         kj5kzbOVmT3Hh7nLVnlArOj6Nlr1ioA8OdATSVGs+s9C+lgS61j0p0C3Fi0LY5K41dd8
         BQ2Lz8sxB5JPQWgZRUrux6sDwC/3YvGBsHBnyiMh5dtHACbKUtcfOFtoCaT1RJ6rzkGe
         YU137FlVos9tnBOfvz2ErbTJtK97kw5bHzLc3JumPfqpAxonH9gxE1zqPhmip0EkcgYN
         V8d1LqIY1F1AkiPy/QOZQar0CuZR2lP8wtPd+fMM7PLMiC1oB4OXRfmLiNnXHLR8sl8H
         pYCw==
X-Gm-Message-State: APjAAAVtMNUBToZodvTBiB5AiTk6OBVSQgNcX7oLVkea8XbrKo60OJmq
        knGm7C+rQND4Uo0cBzvsDkJUdw==
X-Google-Smtp-Source: APXvYqz7BB/aqbr8wvZrYS3zm53Qa+Pz6ZrLainUe1XyeFYrKx0BPyui0jV7qdhS8urpyEaQbyptOQ==
X-Received: by 2002:aa7:9f01:: with SMTP id g1mr77010922pfr.259.1558469567850;
        Tue, 21 May 2019 13:12:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id n27sm48379192pfb.129.2019.05.21.13.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:12:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] mmc: meson-mx-sdio: update with SPDX Licence identifier
In-Reply-To: <20190520143647.2503-3-narmstrong@baylibre.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com> <20190520143647.2503-3-narmstrong@baylibre.com>
Date:   Tue, 21 May 2019 13:12:46 -0700
Message-ID: <7h36l77eip.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
