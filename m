Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE121A1F
	for <lists+linux-mmc@lfdr.de>; Fri, 17 May 2019 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfEQO5E (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 May 2019 10:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbfEQO5E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 May 2019 10:57:04 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB03421743;
        Fri, 17 May 2019 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558105023;
        bh=8NWJcx3ooQ/0x2P9XpShMBRYpatRIjFujdiQFRhPQ7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sHH7dNPs+Ij7ABTDtmkNtRCnGfl0BepHRTE9Sn5RIxZJFk/tv8ReWxQDrvk2a+GVb
         FRjwzlmLUj7wL4bDDBAg5P6I5HxcJlzbG3MXlXrUCDa/4tk6Cgq/lX8tfujobgmGnU
         Ev1WX61YA+OHt85jrhg7kFVF7327X5DdrR2lUU2w=
Received: by mail-qt1-f178.google.com with SMTP id m32so8366393qtf.0;
        Fri, 17 May 2019 07:57:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUdR5jINKx9SB6h8gKG3b2VT11FmdnqtqwbaDdxg010y98c8hd0
        CnT7HfMPceJzTjZ1K1ZFbpJiguO5HA7KEDxL8g==
X-Google-Smtp-Source: APXvYqwtNHRN41jK8D/vYX5vNqxH+cJahtZpPoZtyIj/f0gwgz5EytXbWp2ggnbV5aRbcJF2mVQdCua+GJxN8TOxzHA=
X-Received: by 2002:ac8:3884:: with SMTP id f4mr49917057qtc.300.1558105023022;
 Fri, 17 May 2019 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <225e90a94e9558db9f72f64aca05b0951b88c7c5.1558017853.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <225e90a94e9558db9f72f64aca05b0951b88c7c5.1558017853.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 May 2019 09:56:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+X8uyA6rJFXJWSno8eHz1LAE=Ywvo9DZ4FZTdEEjU=9w@mail.gmail.com>
Message-ID: <CAL_Jsq+X8uyA6rJFXJWSno8eHz1LAE=Ywvo9DZ4FZTdEEjU=9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Add YAML schemas for the generic
 MMC options
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 16, 2019 at 9:44 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The MMC controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>
>   - Added back the cd-inverted and wp-inverted note
>   - Removed the dependency of cd-inverted and wp-inverted on cd-gpios and
>     wp-gpios
>   - Fixed typo in the title
>   - Fixed default in the bus-width property
>   - Fixed typo in the wp-inverted property
>   - Removed redundant type on cd-debounce-delay-ms
>   - Switched the dsr maximum to hex instead of decimal notation
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 358 +++++++-
>  Documentation/devicetree/bindings/mmc/mmc.txt             | 177 +---
>  2 files changed, 358 insertions(+), 177 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc.txt

BTW, in order to avoid updating every reference to mmc.txt, I think it
is better to leave it with a note 'This file has moved to
mmc-controller.yaml'. Then we just update the references when we
convert those bindings.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
