Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4122164D
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Jul 2020 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGOUgJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Jul 2020 16:36:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33791 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOUgI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jul 2020 16:36:08 -0400
Received: by mail-io1-f66.google.com with SMTP id d18so3721703ion.0;
        Wed, 15 Jul 2020 13:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0JZO1a9HR1ox2ONepndmr0Vu5vuUqXp1agE1Jl9N4Us=;
        b=dmlBHQwM78ratsxdk4L+zh2j4YiWQN0q8mLVnxjLn2higGHmFv4w2WEC77NoLF3NeF
         PBr0fvympXdLtL2AAwRyCKNzNyc2FPdFQkyrWtM4YUG9+QULMpinjieqCZGQBLcwSHcN
         /u5RCDCp5CHuQQWdlTsGbo1ponZ441lTVkl0Uz88yAeqVd7PmEt8CZh/hQp/5sEMWySp
         6rWhlNU/rklP5OPScNluXZhie159uzb8NljS58iMboKs11Oe5Fo3GNqjqK6Whs2KH+ZZ
         ZIke+Wb46ObtSzaZhBqsUXsLcUMhAbDQNtFv+obetIcZye+IkBoET1GC1AoHhGfkltpa
         TD5Q==
X-Gm-Message-State: AOAM533dwYtDpWp5JP6pykxoHf8RKr2CNg3a3Ac3XUEwDm7VuuaUK+6S
        9HZRaB+cSz2y7oRUgYOXSQ==
X-Google-Smtp-Source: ABdhPJxNvMfnaMev+pM8hSMD8ESP0J9vtwc5W0QgzgatUro9HYLjnDPR+GRyVFm8cYx1Co1RVHA2Gw==
X-Received: by 2002:a02:6c4c:: with SMTP id w73mr1365670jab.26.1594845367458;
        Wed, 15 Jul 2020 13:36:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t74sm1649640ild.6.2020.07.15.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:36:06 -0700 (PDT)
Received: (nullmailer pid 775001 invoked by uid 1000);
        Wed, 15 Jul 2020 20:36:05 -0000
Date:   Wed, 15 Jul 2020 14:36:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mmc@vger.kernel.org, manish.narani@xilinx.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: convert arasan sdhci bindings to yaml
Message-ID: <20200715203605.GA774948@bogus>
References: <20200701023346.3873-1-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701023346.3873-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 01 Jul 2020 10:33:46 +0800, Wan Ahmad Zainie wrote:
> Convert arasan,sdhci.txt file to yaml. The new file arasan,sdhci.yaml
> will inherit properties from mmc-controller.yaml. 'sdhci' is no longer
> a valid name for node and should be changed to 'mmc'.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 192 -----------
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 299 ++++++++++++++++++
>  2 files changed, 299 insertions(+), 192 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
