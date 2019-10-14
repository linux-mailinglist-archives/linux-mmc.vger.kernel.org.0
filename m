Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE70D6931
	for <lists+linux-mmc@lfdr.de>; Mon, 14 Oct 2019 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfJNSLj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 14 Oct 2019 14:11:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38694 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732772AbfJNSLj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2019 14:11:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so14581076otl.5;
        Mon, 14 Oct 2019 11:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnVDhuScvkPvo4RwDVc8DWG75Gjqf1s3V7qBRLbqCOQ=;
        b=dau4JhbTv7pwHuRl0tCYRlrnrNNJaVui80UTEaIMoVgJqMObrDNPpF5+B382NHtybm
         IOlVn2NTbvUTTVBt+DBgacmt4qnEZaST/7DUIJkLQK6bpngaSMr0PYtkwQA9voNvRh31
         WDf4ovetqra4AeD/xsU0W0p52Jqdu7I2VGOaehbwtkN0YNzVyqV+fT11l8OTavfFIuhp
         q4kzq/5qvHr8vkOxOlfbwFxlJg26vOJGy46IMd6u/6HnSYnY1YiuVIAZSQxJWWmqg871
         EmLIi1vP2haZl62GfQcBVG0TilcTdLm+WUcwU7lfVLP0674EV/oMyUGYmrBORlpZsk5s
         ZjFg==
X-Gm-Message-State: APjAAAWaSQJ22A6rcTWKM1cRxknVvBel0XiQoJJ/PU2aUjcmQXWECkLi
        jAan80yEDcvGFD9wkwq7IQ==
X-Google-Smtp-Source: APXvYqwt3ZBPq4LqtpgI59FJFua/51xF4TfLIs6OjOADJgM4VMCS2ku/+KVb7nuJpUHzNQheLssvAg==
X-Received: by 2002:a05:6830:1be3:: with SMTP id k3mr26208614otb.180.1571076696479;
        Mon, 14 Oct 2019 11:11:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t10sm5581297oib.49.2019.10.14.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 11:11:35 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:11:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, claudiu.beznea@microchip.com,
        Eugen.Hristev@microchip.com,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
Message-ID: <20191014181135.GA4428@bogus>
References: <20191011103340.26749-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011103340.26749-1-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Oct 2019 12:33:37 +0200, Ludovic Desroches wrote:
> There is a new compatible string for the SAM9X60 sdhci device. It involves
> an update of the properties about the clocks stuff.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> Changes:
> - v2: remove the extra example and fix node label
> 
> This patch conflicts with Nicolas' one: "dt-bindings: sdhci-of-at91: add
> the microchip,sdcal-inverted property". Let me know which one has to be
> rebased or you can handle it.
> 
> Ludovic
> 
> 
>  .../devicetree/bindings/mmc/sdhci-atmel.txt       | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
