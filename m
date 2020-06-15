Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E91F9D6C
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jun 2020 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgFOQ26 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jun 2020 12:28:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37403 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgFOQ26 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2020 12:28:58 -0400
Received: by mail-io1-f67.google.com with SMTP id r2so71005ioo.4;
        Mon, 15 Jun 2020 09:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crjYBLmEThzX/ubrSU80z4HF6XsY3k0B4QYp27AbQnw=;
        b=Gk/DtWMYkNTL5DibjSAiLnxVMaEb5urYGjMuVYNeJvJ3kxuzK0wfzNbDQkVoxpevro
         EFQs9PYrCnKTe0I9z+llrO4WBRBsCqzBxfapP/yBC13WYPA3e7UBQA+aNnilVaVaenbS
         EF+yt47yVdw0yE1NkEP0np0gFC3YGwj4+BOqJ17ew0pDoSYNiQsnhjeIGfS7YgDMxOZ3
         NSfnanCE+lNDYA0Ny416UCm8jMvgWUmbwl9qAMFN8hge9TfGgqQNnXgwEz3rMH/VXZtz
         ESUkkXgsMVnbjMjI4w9ux2hK+USPM6LiPSW8DyVl0PT7pYulSr6Qhhvz4QwKTApdDwNE
         h6ew==
X-Gm-Message-State: AOAM532Rs/B18opzPuDPkzYhmgvAB1yLWb8eqWnAB6FRfUvH83tMM4cJ
        ywaNfEoCdSK5PYlEY7LIbEWJbKI=
X-Google-Smtp-Source: ABdhPJxS6wJAJT/g0Pb1HsZ6yVGg+5gSqeG5fcUoDbi72yD1UIqBysfLFirFj8i3qjvTrW9lCBgTAw==
X-Received: by 2002:a05:6638:54:: with SMTP id a20mr21791499jap.3.1592238537002;
        Mon, 15 Jun 2020 09:28:57 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k5sm8154372ili.80.2020.06.15.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:28:56 -0700 (PDT)
Received: (nullmailer pid 1898612 invoked by uid 1000);
        Mon, 15 Jun 2020 16:28:55 -0000
Date:   Mon, 15 Jun 2020 10:28:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        s.hauer@pengutronix.de, mpa@pengutronix.de, festevam@gmail.com
Subject: Re: [PATCH V2 2/3] dt-bindings: mmc: Convert imx mmc to json-schema
Message-ID: <20200615162855.GA1893084@bogus>
References: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
 <1591234886-15351-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591234886-15351-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 04 Jun 2020 09:41:25 +0800, Anson Huang wrote:
> Convert the i.MX MMC binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add "unevaluatedProperties: false".
> ---
>  .../devicetree/bindings/mmc/fsl-imx-mmc.txt        | 23 ----------
>  .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       | 53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> 

Applied, thanks!
