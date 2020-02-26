Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41FA170B5C
	for <lists+linux-mmc@lfdr.de>; Wed, 26 Feb 2020 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBZWTl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 26 Feb 2020 17:19:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42573 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbgBZWTl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 17:19:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so999784otd.9;
        Wed, 26 Feb 2020 14:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWyxiAEzeSmcElmr0LNMnTgSazdAG9/ZOCElmokQbC0=;
        b=eCNQ1bdWelAWWtV12myftWYfi0mIzUn9TFdL12VQmYZL5pH9umxIaCdib3hWzerIVh
         xd3sszSqbCDyPvFYL6T2ARhlNRaN8tfGlwxFDdUFL5O+A8FxJN72so5yBReAuLEuwaxj
         Wm2cmwawaEj7KfNOFKQmp0vAXco9GUKyGtrYwCaqRG9tkI2dTSF2CE09D3C2g6Xc2chF
         mkU9KiP9xSevUaNIm79qnePHOtcIIhAHgB7QmBKzbUkQ7yOJb8UJ6QbHkCciDuju524O
         1dNQs95KXBgbS+UHc2WBLxfho603NCvy+IDzjiTsdUUI2CwYfJR3BfCRgEOMWYskbTIs
         jPoQ==
X-Gm-Message-State: APjAAAWJWMeRNEkmeicsfsS7u+qc0PIbFCJd/U8GqmPght53cUi8Xbks
        VDVLKB5oZi7hYE+g504E9w==
X-Google-Smtp-Source: APXvYqxcI1f7yAERZ6QtTzOxTYytk6rNbUmt2uL+TovzB/3tIvg04EuFZo6tZhS82ySexTPuu7HfIA==
X-Received: by 2002:a9d:4d96:: with SMTP id u22mr690140otk.271.1582755580501;
        Wed, 26 Feb 2020 14:19:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h1sm1230129otm.34.2020.02.26.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:19:39 -0800 (PST)
Received: (nullmailer pid 3500 invoked by uid 1000);
        Wed, 26 Feb 2020 22:19:39 -0000
Date:   Wed, 26 Feb 2020 16:19:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Convert UniPhier SD controller to
 json-schema
Message-ID: <20200226221939.GA3373@bogus>
References: <20200222112541.573-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222112541.573-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 22 Feb 2020 20:25:41 +0900, Masahiro Yamada wrote:
> Convert the UniPhier SD controller binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> If there is a better way to describe reset-names,
> please let me know.
> 
> 
>  .../bindings/mmc/socionext,uniphier-sd.yaml   | 99 +++++++++++++++++++
>  .../devicetree/bindings/mmc/uniphier-sd.txt   | 55 -----------
>  2 files changed, 99 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
> 

Applied, thanks.

Rob
